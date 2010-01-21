class TextCustomFormElement < CustomFormElement

  @@text_config = nil

  def self.config
    return @@text_config unless @@text_config.nil?

    @@text_config = CustomFormElementConfig.new(
      :text, 'Text Input',
      :collecting => true,
      :accessors => {:label => :direct_value}
    )
    @@text_config.freeze

    return @@text_config
  end

end
