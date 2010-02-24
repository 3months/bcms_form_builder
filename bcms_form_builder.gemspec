# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bcms_form_builder}
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["3months - Kim Chirnside"]
  s.date = %q{2009-12-26}
  s.description = %q{Custom form builder for public BCMS pages}
  s.email = %q{kim@3months.com}
  s.extra_rdoc_files = [
     "README"
  ]
  s.files = [
    "app/controllers/cms/custom_form_elements_controller.rb",
    "app/controllers/cms/custom_forms_controller.rb",
    "app/helpers/cms/custom_forms_helper.rb",
    "app/models/check_box_custom_form_element.rb",
    "app/models/custom_form.rb",
    "app/models/custom_form_element.rb",
    "app/models/custom_form_element_attribute.rb",
    "app/models/custom_form_element_config.rb",
    "app/models/custom_form_element_validation.rb",
    "app/models/custom_form_submission.rb",
    "app/models/description_custom_form_element.rb",
    "app/models/html_block_custom_form_element.rb",
    "app/models/radio_button_custom_form_element.rb",
    "app/models/select_custom_form_element.rb",
    "app/models/string_custom_form_element.rb",
    "app/models/submit_custom_form_element.rb",
    "app/models/text_custom_form_element.rb",
    "app/models/title_custom_form_element.rb",
    "app/portlets/custom_form_basic_portlet.rb",
    "app/portlets/custom_form_success_portlet.rb",
    "app/views/cms/custom_forms/display/_check_box_element.html.erb",
    "app/views/cms/custom_forms/display/_description_element.html.erb",
    "app/views/cms/custom_forms/display/_html_block_element.html.erb",
    "app/views/cms/custom_forms/display/_radio_button_element.html.erb",
    "app/views/cms/custom_forms/display/_select_element.html.erb",
    "app/views/cms/custom_forms/display/_string_element.html.erb",
    "app/views/cms/custom_forms/display/_submit_element.html.erb",
    "app/views/cms/custom_forms/display/_text_element.html.erb",
    "app/views/cms/custom_forms/display/_title_element.html.erb",
    "app/views/cms/custom_forms/forms/_check_box_element.html.erb",
    "app/views/cms/custom_forms/forms/_description_element.html.erb",
    "app/views/cms/custom_forms/forms/_html_block_element.html.erb",
    "app/views/cms/custom_forms/forms/_element_management_links.html.erb",
    "app/views/cms/custom_forms/forms/_radio_button_element.html.erb",
    "app/views/cms/custom_forms/forms/_select_element.html.erb",
    "app/views/cms/custom_forms/forms/_string_element.html.erb",
    "app/views/cms/custom_forms/forms/_submit_element.html.erb",
    "app/views/cms/custom_forms/forms/_text_element.html.erb",
    "app/views/cms/custom_forms/forms/_title_element.html.erb",
    "app/views/cms/custom_forms/_form.html.erb",
    "app/views/cms/custom_forms/render.html.erb",
    "app/views/cms/custom_form_elements/edit.html.erb",
    "app/views/cms/custom_form_elements/index.html.erb",
    "app/views/cms/custom_form_elements/_toolbar.html.erb",
    "app/views/cms/custom_form_elements/forms/_check_box_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_description_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_html_block_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_radio_button_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_select_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_string_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_submit_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_text_custom_form_element.html.erb",
    "app/views/cms/custom_form_elements/forms/_title_custom_form_element.html.erb",
    "app/views/cms/form_builder/_cms_file_field.html.erb",
    "app/views/cms/form_builder/_cms_validation_options.html.erb",
    "app/views/portlets/custom_form_basic/_form.html.erb",
    "app/views/portlets/custom_form_basic/render.html.erb",
    "app/views/portlets/custom_form_success/_form.html.erb",
    "app/views/portlets/custom_form_success/render.html.erb",
    "db/migrate/20091216224924_create_custom_forms.rb",
    "db/migrate/20091216225401_create_custom_form_elements.rb",
    "db/migrate/20091217214512_create_custom_form_element_attributes.rb",
    "db/migrate/20100115022104_create_custom_form_element_validations.rb",
    "lib/bcms_form_builder.rb",
    "lib/bcms_form_builder/routes.rb",
    "lib/bcms_form_builder/helpers.rb",
    "public/stylesheets/form_builder.css",
    "public/javascripts/form_builder.js",
    "rails/init.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://www.3months.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Custom form builder for public BCMS pages}
  s.test_files = []

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.3.0') then
    else
    end
  else
  end
end
