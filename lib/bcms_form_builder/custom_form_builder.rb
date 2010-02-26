class Cms::CustomFormBuilder < Cms::FormBuilder

  %w[check_box validation_options options_collection].each do |f|
    src = <<-end_src
      def cms_#{f}(method, options={})
        add_tabindex!(options)
        set_default_value!(method, options)
        cms_options = options.extract!(:label, :instructions, :default_value)
        render_cms_form_partial :#{f},
          :object_name => @object_name, :method => method,
          :options => options, :cms_options => cms_options
      end
    end_src
    class_eval src, __FILE__, __LINE__
  end
  
end

ActionView::Base.default_form_builder = Cms::CustomFormBuilder
