class CheckBoxCustomFormElement < CustomFormElement

  @@check_box_config = nil

  def self.config
    return @@check_box_config unless @@check_box_config.nil?

    @@check_box_config = CustomFormElementConfig.new(
      :check_box, 'Check Box Input',
      :collecting => true,
      :accessors => {:label => :direct_value, :options => :check_box_options},
      :readers => {:options_array => [:options, :check_box_options_array]}
    )
    @@check_box_config.freeze

    return @@check_box_config
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
