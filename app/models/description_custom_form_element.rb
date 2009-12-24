class DescriptionCustomFormElement < CustomFormElement

  @@description_config = nil

  def self.config
    return @@description_config unless @@description_config.nil?

    @@description_config = CustomFormElementConfig.new(
      :description, 'Text Block',
      :accessors => {:text => :direct_value}
    )
    @@description_config.freeze

    return @@description_config
  end

end
