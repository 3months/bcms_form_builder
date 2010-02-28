require 'bcms_form_builder/routes'
require 'bcms_form_builder/helpers'

require 'bcms_form_builder/custom_form_builder'
# This inclusion works when loaded as a gem, however when built into the application
# (ie. initial development of this module) this line is needed at the end of
# environment.rb
ActionView::Base.default_form_builder = Cms::CustomFormBuilder

ActionView::Base.default_form_builder = Cms::CustomFormBuilder

