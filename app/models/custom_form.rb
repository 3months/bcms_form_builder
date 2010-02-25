class CustomForm < ActiveRecord::Base
  acts_as_content_block :versioned => false, :belongs_to_attachment => true

  has_many :custom_form_elements, :order => "position ASC"
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :email
  validates_length_of :email, :maximum => 255
  validates_length_of :success_url, :maximum => 255, :allow_blank => true

  before_update :validate_elements
  after_update :save_elements

  # elements=
  #
  # Accessor metod to assign @custom_form_elements from form data received by request
  # params.  Params have been inpected and relevant parts passed as <elements_hash>.
  #
  # See CustomFormElement#build_batch for required format of <elements_hash>
  #
  def elements=(elements_hash)
    CustomFormElement.build_batch(elements_hash, self)
    # this is to trick callbacks into thinking that record has changed
    # required to ensure that cascading save works.  # TODO Not ideal solution
    self.name_will_change!

    logger.debug("CustomForm has #{self.custom_form_elements.length} elements attached")
  end

  def next_elements_position
    base_element = self.custom_form_elements.inject do |memo, element|
      element.position && memo && memo.position > element.position ? memo : element
    end
    base_position = base_element ? base_element.position.to_i : 0
    
    return base_position + 1
  end

  def reorder_elements!(element_order)
    elements = self.custom_form_elements
    elements.each do |el|
      element_order << el.id.to_s unless element_order.include?(el.id.to_s)
    end
    elements.sort! {|a, b| element_order.index(a.id.to_s) <=> element_order.index(b.id.to_s)}

    elements.each_with_index do |el, i|
      el.update_attribute(:position, i + 1)
    end
  end

  private

    # validate_elements
    #
    # Called before form is updated.  Fail form validation if any of the form
    # elements cannot be validated.
    #
    def validate_elements
      errors = []
      self.custom_form_elements.each do |element|
        errors << element unless element.valid?
      end

      self.errors.add(:custom_form_elements, "Errors were detected in the elements of this form") if errors.length > 0
      return errors.length == 0
    end

    # save_elements
    #
    # Called after form is updated.  Due to rails not performing cascading updates
    # on has_may relationship, we need to save each child if it has changed.  This
    # is done in conjunction with #validate_elements which enables us to call
    # `save(false)`
    #
    def save_elements
      self.custom_form_elements.each do |element|
        element.save(false) if element.changed?
      end

      # If we deleted any elements during the update process, they will now have a NULL
      # id.  We actually want to delete them.
      # TODO not ideal solution
      CustomFormElement.destroy_all("custom_form_id IS NULL")
      
      return true
    end

end
