class TextCustomFormElement < CustomFormElement

  @@text_config = nil

  def self.config
    return @@text_config unless @@text_config.nil?

    @@text_config = CustomFormElementConfig.new(
      :text, 'Text Input',
      :collecting => true,
      :accessors => {:label => :direct_value, :classes => :class_values},
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@text_config.freeze

    return @@text_config
  end

end
