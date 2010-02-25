class RadioButtonCustomFormElement < CustomFormElement

  @@radio_button_config = nil

  def self.config
    return @@radio_button_config unless @@radio_button_config.nil?

    @@radio_button_config = CustomFormElementConfig.new(
      :radio_button,
      'Radio Button Input',
      :collecting => true,
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :label => :direct_value,
        :disabled => :boolean_value, # input tag's diabled attribute
        :classes => :class_values,
        :options => :radio_button_options
      ),
      :readers => {:options_array => [:options, :radio_button_options_array], :class_array => [:classes, :class_array]}
    )
    @@radio_button_config.freeze

    return @@radio_button_config
  end

  # self.print_value
  #
  # Should be a Hash.  If not just #inspect.  If Hash, render as a list of keys.
  #
  def self.print_value(value)
    return value.inspect unless value.is_a?(Hash)

    return value.keys.map {|k| k.inspect}.join(', ')
  end

end
