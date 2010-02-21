class CustomFormSuccessPortlet < Portlet

  handler 'erb'
  
  def render
    if flash['submission'].is_a?(Hash)
      @custom_form = CustomForm.find_by_id(flash['submission'][:custom_form_id].to_i)
    else
      @custom_form = nil
    end
  end
    
end