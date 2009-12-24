class SelectCustomFormElement < CustomFormElement

  @@select_config = nil

  def self.config
    return @@select_config unless @@select_config.nil?

    @@select_config = CustomFormElementConfig.new(
      :select, 'Select Input',
      :collecting => true,
      :accessors => {:label => :direct_value, :options => :select_options, :classes => :class_values},
      :readers => {:options_array => [:options, :select_options_array], :class_array => [:classes, :class_array]}
    )
    @@select_config.freeze

    return @@select_config
  end

end
