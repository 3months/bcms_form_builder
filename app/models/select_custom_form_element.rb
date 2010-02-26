class SelectCustomFormElement < CustomFormElement

  @@select_config = nil

  def self.config
    return @@select_config unless @@select_config.nil?

    @@select_config = CustomFormElementConfig.new(
      :select,
      'Select Input',
      :collecting => true,
      # TODO add 'not blank' style validation to selects
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
