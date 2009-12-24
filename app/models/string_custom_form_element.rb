class StringCustomFormElement < CustomFormElement

  @@string_config = nil

  def self.config
    return @@string_config unless @@string_config.nil?

    @@string_config = CustomFormElementConfig.new(
      :string, 'String Input',
      :collecting => true,
      :accessors => {:label => :direct_value, :classes => :class_values},
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@string_config.freeze

    return @@string_config
  end

end
