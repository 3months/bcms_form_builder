class Cms::CustomFormsController < Cms::ContentBlockController

  # new_element
  #
  # Renders the partial for a new CustomFormElement.  Gives the item a unique index
  # based on the session[:form_builder] hash, which keeps a counter of the last
  # index.  NOTE: this counter is reset by each page render of a new CustomForm
  # new/edit form.
  #
  def new_element
    unless params[:type] && (klass = CustomFormElement.subclass(params[:type]))
      render :nothing => true, :status => 404
      return
    end

    element = klass.new
    index = (session[:form_builder] ||= {:element_index => 0})[:element_index].to_i + 1
    session[:form_builder][:element_index] += 1
    
    render :partial => "cms/custom_forms/forms/#{klass.config.name}_element", :locals => {:index => "new_#{index}", :element => element}
  end

end