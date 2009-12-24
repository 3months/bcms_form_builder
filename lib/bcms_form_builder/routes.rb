module Cms::Routes
  def routes_for_bcms_form_builder
    namespace(:cms) do |cms|      
      cms.content_blocks :custom_forms
    end
  end
end
