class DescriptionCustomFormElement < CustomFormElement

  @@description_config = nil

  def self.config
    return @@description_config unless @@description_config.nil?

    @@description_config = CustomFormElementConfig.new(
      :description,
      'Text Block',
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :text => :direct_value,
        :classes => :class_values
        # delete some defaults for this non-input element
      ).delete_if{ |k, v| [:exclude_from_results].include?(k) },
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@description_config.freeze

    return @@description_config
  end

end
