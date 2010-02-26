class TextCustomFormElement < CustomFormElement

  @@text_config = nil

  def self.config
    return @@text_config unless @@text_config.nil?

    @@text_config = CustomFormElementConfig.new(
      :text,
      'Text Input',
      :collecting => true,
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :label => :direct_value, 
        :disabled => :boolean_value, # textarea tag's diabled attribute
        :default_value => :direct_value, # textarea tag's value attribute
        :classes => :class_values
      )#,
      #:readers => {:class_array => [:classes, :class_array]}
    )
    @@text_config.freeze

    return @@text_config
  end

end
