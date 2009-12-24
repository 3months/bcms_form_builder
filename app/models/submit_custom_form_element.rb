class SubmitCustomFormElement < CustomFormElement

  @@submit_config = nil

  def self.config
    return @@submit_config unless @@submit_config.nil?

    @@submit_config = CustomFormElementConfig.new(
      :submit, 'Submit Button',
      :accessors => {:classes => :class_values, :label => :direct_value},
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@submit_config.freeze

    return @@submit_config
  end

end
