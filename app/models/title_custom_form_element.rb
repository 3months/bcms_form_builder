class TitleCustomFormElement < CustomFormElement

  @@title_config = nil

  def self.config
    return @@title_config unless @@title_config.nil?

    @@title_config = CustomFormElementConfig.new(
      :title, 'Title',
      :accessors => {:title => :direct_value}
    )
    @@title_config.freeze

    return @@title_config
  end

end
