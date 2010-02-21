class SubmitCustomFormElement < CustomFormElement

  @@submit_config = nil

  def self.config
    return @@submit_config unless @@submit_config.nil?

    @@submit_config = CustomFormElementConfig.new(
      :submit, 'Submit Button',
      :accessors => {:label => :direct_value, :classes => :class_values},
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@submit_config.freeze

    return @@submit_config
  end

end
