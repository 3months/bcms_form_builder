class TitleCustomFormElement < CustomFormElement
  
  @@title_config = nil

  def self.config
    return @@title_config unless @@title_config.nil?

    @@title_config = CustomFormElementConfig.new(
      :title, 'Title',
      :accessors => {:title => :direct_value, :tag => :direct_value, :classes => :class_values},
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@title_config.freeze

    return @@title_config
  end

end
