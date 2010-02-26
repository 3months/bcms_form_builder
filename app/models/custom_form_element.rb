class CustomFormElement < ActiveRecord::Base
  include FormBuilder::Helpers

  belongs_to :custom_form
  # :dependent => :destroy required, else #build_attributes causes many orphan
  # CustomFormElementAttributes to be created
  has_many :custom_form_element_attributes, :dependent => :destroy
  has_many :custom_form_element_validations, :dependent => :destroy

  validates_presence_of :name
  validates_length_of :name, :maximum => 255

  attr_accessor :non_ar_errors

  SUBCLASSES = [
    'TitleCustomFormElement',
    'DescriptionCustomFormElement',
    'HtmlBlockCustomFormElement',
    'StringCustomFormElement',
    'TextCustomFormElement',
    'SelectCustomFormElement',
    'CheckBoxCustomFormElement',
    'RadioButtonCustomFormElement',
    'SubmitCustomFormElement'
  ]

  CONFIG_DEFAULT_ACCESSORS = {
    :exclude_from_results => :boolean_value
  }

  # self.subclass
  #
  # Fetch class constant for class of type <string>.  Checks that <string> is a valid
  # type before attempting the evaluation.  Use instead of inline #eval
  #
  def self.subclass(string)
    return nil unless SUBCLASSES.include?(string)

    return eval(string)
  end

  # self.subclasses_for_select_options
  #
  # List of all subclasses as Array of [<display_name>, <class_name>] pairs.  For
  # use in select dropdowns, to choose which element type to use.
  #
  def self.subclasses_for_select_options
    return SUBCLASSES.map do |key|
      sc = subclass(key)
      sc ? [sc.config.display_name, key] : nil
    end.compact
  end

  # self.config
  #
  # To be overloaded by subclasses
  #
  def self.config
    return nil
  end

  # self.print_value
  #
  # Default print method for associate value.  Different elements will store their data
  # in different structures.  They would override this method to display their
  # structure nicely.
  #
  def self.print_value(value)
    return value.inspect
  end

  # self.build_batch
  #
  def self.build_batch(elements_hash, parent)
    new_elements = []
    old_elements = parent.custom_form_elements.map {|e| e}
    base_position = parent.next_elements_position

    elements_hash.each do |k, v|
      next unless klass = subclass(v.delete(:type))
      
      if parent.new_record? || !k.match(/^\d+$/)
        new_elements << klass.new
      else
        new_elements << old_elements.detect {|old_el| old_el.id == k.to_i} || klass.new
      end

      # An initial version had the position passable from the UI, however now
      # we don't support this.  Leaving this condition in so we can support it
      # later...
      position = v.delete(:position)
      if position.to_s.match(/^\d+$/)
        position = position.to_i
      else
        position = base_position
        base_position += 1
      end
      latest_element = new_elements.last
      latest_element.position = position
      latest_element.name = v.delete(:name)

      latest_element.attributes = v

      logger.debug("Assigning type: #{latest_element.class} to form in position #{latest_element.position}")
    end

    return parent.custom_form_elements = new_elements
  end

  #
  # TODO this has been superceded by attributes=
#  def build_attributes(attribute_hash)
#    validations = attribute_hash.delete(:validations)
#    if validations
#      logger.debug("Validation options passed: #{validations}")
#    end
#    self.build_validations(validations)
#
#    logger.debug("Building #{self.class} attribute for form element")
#    self.custom_form_element_attributes = CustomFormElementAttribute.build_input_attributes(attribute_hash, self.class.config)
#  end

  # attributes=
  #
  # Fetches all constructed attributes via #build_input_attributes and triggers the
  # building of validations on this element via #build_validations
  def attributes=(attribute_hash)
    validations = attribute_hash.delete(:custom_form_element_validations)
    if validations
      logger.debug("Validation options passed: #{validations}")
    end
    self.build_validations(validations)

    new_name = attribute_hash.delete(:name)
    self.name = new_name if new_name

    logger.debug("Building #{self.class} attribute for form element")
    self.custom_form_element_attributes = CustomFormElementAttribute.build_input_attributes(attribute_hash, self.class.config)
  end

  # load_element
  #
  # For loadable attributes of this element type (self.custom_form_element_type), dynamically
  # create accessor methods to read these attributes.
  #
  # Examples include fetching the classes of the element, or the options for a select
  # box.
  #
  def load_element
    accessors = self.class.config.accessors
    readers = self.class.config.readers

    accessors.each do |key|
      build_read_method(key, self.class.config.accessor_db_key(key), self.class.config.accessor_method(key))
      build_write_method(key, self.class.config.accessor_db_key(key), self.class.config.accessor_method(key))
    end
    readers.each do |key|
      build_read_method(key, self.class.config.reader_db_key(key), self.class.config.reader_method(key))
    end

  end

  # build_read_method
  #
  # Create dynamic reader method named <method>.  This finds an element_attribute
  # of type db_key and then calls the <fetch_method> on the element_attribute to
  # return the underlying values.
  #
  def build_read_method(method, db_key, fetch_method)
    new_method = %Q/
      def #{method.to_s}
        attribute = self.custom_form_element_attributes.detect {|att| att.key == %Q-#{db_key.to_s}-}
        return nil unless attribute

        return attribute.#{fetch_method.to_s}
      end
    /

    logger.debug("Creating dynamic method as: #{new_method}")
    instance_eval new_method
  end

  # build_write_method
  #
  # Create dynamic writer method named <method>=.  This updates or creates an
  # element_attribute of type db_key, depending on whether one already exists for
  # this element and then calls the <fetch_method> on the element_attribute to
  # return the underlying values.
  #
  # TODO - there is a flaw here.  If the attribute does not exist it uses the <<
  # operator, which for this has_many relationship, saves the record immediately
  # if self is not new.  Not sure if this is dangerous behaviour at this point.
  #
  def build_write_method(method, db_key, put_method)
    new_method = %Q/
      def #{method.to_s}=(value)
        attribute = self.custom_form_element_attributes.detect {|att| att.key == %Q-#{db_key.to_s}-}
        unless attribute
          attribute = CustomFormElementAttribute.build_input_attribute('#{db_key.to_s}', value, '#{put_method.to_s}')
          self.custom_form_element_attributes << attribute
        end
      end
    /

    logger.debug("Creating dynamic method as: #{new_method}")
    instance_eval new_method
  end

  # html_attribute_name
  #
  # To remove requirement for users to enter a 'key' type name (lowercase with underscores
  # in this case), we always refer to elements by an implicit key.
  #
  # This method returns that implicit key, base on @name.
  #
  def html_attribute_name
    return string_to_html_name(self.name)
  end

  # available_validations
  #
  def available_validations
    return self.class.config.validations
  end

  # build_validations
  #
  def build_validations(validation_hash)
    self.custom_form_element_validations = []
    return unless validation_hash.is_a?(Array)
    
    validation_hash.each do |key|
      next unless key.respond_to?(:intern)
      next unless self.available_validations[key.intern]

      self.custom_form_element_validations << CustomFormElementValidation.new(:key => key.to_s)
    end
  end

  # non_ar_validate
  #
  def non_ar_validate(value)
    valid = true
    self.custom_form_element_validations.each do |validation|
      test = send(validation.key.intern, value)
      if test.is_a?(ValidationError)
        valid = false
        add_error(test)
      end
    end

    return valid
  end

  protected

    class ValidationError
      
      attr_reader :message

      def initialize(message)
        @message = message
      end
    end

    def add_error(error)
      self.non_ar_errors ||= []
      self.non_ar_errors << error
    end
  
end
