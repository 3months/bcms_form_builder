class TitleCustomFormElement < CustomFormElement
  
  @@title_config = nil

  def self.config
    return @@title_config unless @@title_config.nil?

    @@title_config = CustomFormElementConfig.new(
      :title,
      'Title',
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :title => :direct_value,
        :tag => :direct_value,
        :classes => :class_values
        # delete some defaults for this non-input element
      ).delete_if{ |k, v| [:exclude_from_results].include?(k) }#,
      #:readers => {:class_array => [:classes, :class_array]}
    )
    @@title_config.freeze

    return @@title_config
  end

end
