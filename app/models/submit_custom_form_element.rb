class SubmitCustomFormElement < CustomFormElement

  @@submit_config = nil

  def self.config
    return @@submit_config unless @@submit_config.nil?

    @@submit_config = CustomFormElementConfig.new(
      :submit, 'Submit Button',
      :accessors => {:label => :direct_value}
    )
    @@submit_config.freeze

    return @@submit_config
  end

end
