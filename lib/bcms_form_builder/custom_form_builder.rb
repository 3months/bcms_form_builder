class Cms::CustomFormBuilder < Cms::FormBuilder

  # This is a repetition of method generator in browsercms-3.0.6/app/helpers/cms/form_helper.rb
  #
  # Cannot at this point find a tidier way to replicate this.  Might request a
  # change in the way this is done in core, to allow simpler overloading.

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

# This inclusion works when loaded as a gem, however when built into the application
# (ie. initial development of this module) this line is needed at the end of
# environment.rb
ActionView::Base.default_form_builder = Cms::CustomFormBuilder
