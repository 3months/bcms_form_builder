# CustomFormSubmission
#
# Represents a non-persistent form submission. @parameters contains the user data
# submitted.  @completed elements is a finalised list of CustomFormElement/Data
# pairs.
#
# Supports validation based on the CustomFormElementValidation defined on the
# individual CustomFormElements
#
# Builds @errors based on the instances of failed CustomFormElementValidation
#
class CustomFormSubmission

  attr_reader :custom_form_id
  attr_reader :errors

  def initialize(custom_form, parameters)
    @parameters = parameters
    @custom_form = custom_form
    @completed_elements = []
    @errors = {}
  end

  def each(options = {})
    elements = options[:recordable] ? recordable_pairs : @completed_elements
    elements.each do |pair|
      yield pair
    end
  end

  # TODO method not currently used.  Did I have something in mind for it?
  # 
#  def element_keys
#    return @completed_elements.map {|el| el.first.html_attribute_name}
#  end

  # add_element
  #
  # Add new [CustomFormElement, data] pair to the final list based on <element>.
  # <element> must be a subclass of CustomFormElement.
  #
  def add_element(element)
    @completed_elements << [element, @parameters[element.html_attribute_name]]
  end

  # fetch_element
  #
  # Returns the [CustomFormElement, data] pair whose element has a name (or key)
  # that matches <key>.  Returns nil if not found.
  #
  def fetch_element(key)
    return @completed_elements.detect do |el|
      el.first.html_attribute_name == key || el.first.name == key
    end
  end

  # fetch_element
  #
  # Returns the data for the pair in @complete_elements, whose element has a
  # name (or key) that matches <key>.  Returns nil if not found.
  #
  def fetch_value(key)
    return nil unless el_pair = fetch_element(key)
    return el_pair.last
  end

  # send_results!
  #
  # Queue mail in BCMS internal mail queue, with recipients marked as <receipients>.
  #
  def send_results!(recipients)
    EmailMessage.create(
      :recipients => recipients,
      :subject => "Form Submission: [#{@custom_form.name}]",
      :body => email_contents
    )
  end

  # validate
  #
  # NOTE: This is NOT ActiveRecord validation.  Checks each pair in @completed_elements
  # and runs their individual validation routines.  CustomFormElement#non_ar_validate
  # defines the custom validation at the element level.
  #
  # Adds errors to error colletion if detected and returns true if valid and false
  # if invalid.
  #
  def validate
    valid = true
    each do |pair|
      unless pair.first.non_ar_validate(pair.last)
        add_error(pair.first, pair.first.non_ar_errors)
        valid = false
      end
    end

    return valid
  end

  private

    # add_error
    #
    # Add a single error to @errors collection.  <element> should be a subclass
    # of CustomFormElement and <errors> should contain a form of error object.
    #
    def add_error(element, errors)
      @errors[element.name] = errors
    end

    # recordable_pairs
    #
    # Return subset of @completed_elements, containing pairs whose element is NOT
    # explicitly excluded from the results.  See CustomFormElementAttribute with key
    # 'exclude_from_results' of the CustomFormElement for implementation.
    #
    def recordable_pairs
      return @completed_elements.map do |pair|
        pair unless pair.first.respond_to?(:exclude_from_results) && !!pair.first.exclude_from_results
      end.compact
    end

    def email_contents
      values = []
      self.each(:recordable => true) do |pair|
        values << "\t#{pair.first.name}: #{pair.first.class.print_value(pair.last) unless pair.last.blank?}"
      end

      return <<-STRING
The following details were submitted as part of form #{@custom_form.name}:

#{values.join("\n")}
STRING
    end

end
