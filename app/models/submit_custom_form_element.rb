class SubmitCustomFormElement < CustomFormElement

  @@submit_config = nil

  def self.config
    return @@submit_config unless @@submit_config.nil?

    @@submit_config = CustomFormElementConfig.new(
      :submit,
      'Submit Button',
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :label => :direct_value,
        :classes => :class_values
        # delete some defaults for this non-input element
      ).delete_if{ |k, v| [:exclude_from_results].include?(k) }#,
      #:readers => {:class_array => [:classes, :class_array]}
    )
    @@submit_config.freeze

    return @@submit_config
  end

end
