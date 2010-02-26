class CustomFormBasicPortlet < Portlet

  handler 'erb'

  def render
    @form = CustomForm.find_by_id(self.custom_form_id.to_i)
  end

  # submit_form
  #
  # Portlet handler method to process form submission contents.  Currently processes
  # contents and produces an email containing the results.  The email is added
  # to the internal mail queue for BCMS.
  #
  # URL for this action can be rendered using cms_handler_path(@portlet, "submit_form")
  # in the appropriate CustomFormBasicPortlet portlet.
  #
  def submit_form
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

    # Custom validation for CustomForm - not ActiveRecord validation
    if @custom_form.validate
      recipients = portlet.email_address.to_s.strip
      recipients = @form.email if recipients.blank?

      @custom_form.send_results!(recipients)

      store_hash_in_flash('submission', {:custom_form_id => @form.id})
      @form.success_url
    else
      # TODO have not tested failure mode thoroughly - some validation messages may be
      # a bit rough and/or exploding
      store_params_in_flash
      store_errors_in_flash(@custom_form.errors)
      url_for_failure
    end
  rescue ActiveRecord::RecordNotFound
    url_for_failure
  end
    
end