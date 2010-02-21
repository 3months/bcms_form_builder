class Cms::CustomFormElementsController < Cms::ApplicationController
  layout 'cms/content_library'

  helper "cms/custom_forms"

  helper_method :block_form, :content_type

  def index
    load_block

    @form_elements = @block.custom_form_elements
  rescue ActiveRecord::RecordNotFound
    redirect_to cms_custom_forms_path
  end

  def edit
    load_block_and_element
    
  rescue ActiveRecord::RecordNotFound
    redirect_to cms_custom_form_custom_form_elements_path
  end

  def update
    load_block_and_element
    
    @form_element.update_attributes!(params[block_form])
  rescue ActiveRecord::RecordInvalid
    
  rescue ActiveRecord::RecordNotFound
    redirect_to cms_custom_form_custom_form_elements_path
  end

  protected

    def content_type
      @content_type ||= ContentType.find_by_key('CustomForm')
    end

    def block_form
      @form_element.class.name.underscore.to_sym
    end

  private

    def load_block
      @block = CustomForm.find(params[:custom_form_id])
      @block = @block.as_of_draft_version if CustomForm.versioned?
    end

    def load_block_and_element
      load_block
      @form_element = CustomFormElement.find(params[:id], :conditions => ["custom_form_id = ?", @block.id])
    end

end