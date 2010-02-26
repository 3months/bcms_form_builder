module Cms::Routes
  def routes_for_bcms_form_builder
    namespace(:cms) do |cms|      
      cms.content_blocks :custom_forms, :member => {:order_elements => :post}, :collection => {:new_element_partial => :get, :new_element => [:get, :post]}, :has_many => [:custom_form_elements]
    end
  end
end
