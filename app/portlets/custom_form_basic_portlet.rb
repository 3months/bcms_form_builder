class CustomFormBasicPortlet < Portlet

  handler 'erb'

  def render
    @form = CustomForm.find_by_id(self.custom_form_id.to_i)
  end

  def submit_form
    begin
      portlet = Portlet.find(params[:id])
      @form = CustomForm.find_by_id(self.custom_form_id.to_i)

      @custom_form = CustomFormSubmission.new(@form, params[:custom_form])

      @form.custom_form_elements.each do |element|
        next unless element.class.config.collecting == true

        @custom_form.add_element(element)
        
        element.load_element
        logger.info("*********************************************************")
        logger.info("Contents of element #{element.name} are: #{params[:custom_form][element.html_attribute_name.intern]}")
        logger.info("*********************************************************")
      end

      recipients = portlet.email_address.to_s.strip
      recipients = @form.email if recipients.blank?

      @custom_form.send_results!(recipients)

      store_hash_in_flash('submission', {:custom_form_id => @form.id})
      @form.success_url
    rescue ActiveRecord::RecordNotFound
      url_for_failure
#    rescue Exception
#      store_params_in_flash
#      store_errors_in_flash(@custom_form.errors)
    end

  end
    
end