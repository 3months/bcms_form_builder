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

  def element_keys
    return @completed_elements.map {|el| }
  end

  def add_element(element)
    @completed_elements << [element, @parameters[element.html_attribute_name]]
  end

  def fetch_element(key)
    return @completed_elements.detect do |el|
      el.first.html_attribute_name == key || el.first.name == key
    end
  end

  def fetch_value(key)
    return nil unless el_pair = fetch_element(key)
    return el_pair.last
  end

  def send_results!(recipients)
    EmailMessage.create(
      :recipients => recipients,
      :subject => "Form Submission: [#{@custom_form.name}]",
      :body => email_contents
    )
  end

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
