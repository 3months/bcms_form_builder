require 'bcms_form_builder/routes'
require 'bcms_form_builder/helpers.rb'
require 'bcms_form_builder/custom_form_builder.rb'

ActionView::Base.default_form_builder = Cms::CustomFormBuilder

