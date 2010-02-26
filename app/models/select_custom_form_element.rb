class SelectCustomFormElement < CustomFormElement

  @@select_config = nil

  def self.config
    return @@select_config unless @@select_config.nil?

    @@select_config = CustomFormElementConfig.new(
      :select,
      'Select Input',
      :collecting => true,
<<<<<<< HEAD:app/models/select_custom_form_element.rb
      # TODO add 'not blank' style validation to selects
=======
>>>>>>> 3fd048bcdb84520b748659a1a270fdc92648956b:app/models/select_custom_form_element.rb
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :label => :direct_value,
        :disabled => :boolean_value, # select tag's diabled attribute
        :classes => :class_values,
        :options => :select_options
      )#,
      #:readers => {:options_array => [:options, :select_options_array], :class_array => [:classes, :class_array]}
    )
    @@select_config.freeze

    return @@select_config
  end

end
