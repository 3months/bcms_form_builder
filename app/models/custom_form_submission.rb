class CustomFormSubmission

  attr_reader :custom_form_id

  def initialize(custom_form, parameters)
    @parameters = parameters
    @custom_form = custom_form
    @completed_elements = []
  end

  def each
    @completed_elements.each do |pair|
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

  private

    def email_contents
      values = []
      self.each do |pair|
        values << "\t#{pair.first.name}: #{pair.first.class.print_value(pair.last) unless pair.last.blank?}"
      end

      return <<-STRING
The following details were submitted as part of form #{@custom_form.name}:

#{values.join("\n")}
STRING
    end

end
