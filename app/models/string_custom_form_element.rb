class StringCustomFormElement < CustomFormElement

  @@string_config = nil

  def self.config
    return @@string_config unless @@string_config.nil?

    @@string_config = CustomFormElementConfig.new(
      :string, 'String Input',
      :collecting => true,
      :validations => {:presence_of => {:display_name => 'Not blank', :message => "%s cannot be blank"}},
      :accessors => {:label => :direct_value}
    )
    @@string_config.freeze

    return @@string_config
  end

  private

    # validation method mapping to the :presence_of key in self.config[:validations]
    #
    # presence_of checks that the value is both not null, empty or only contains whitespace.
    # Returns
    def presence_of(input_value)
      if input_value.to_s.strip.length > 0
        return true
      else
        return ValidationError.new(self.class.config.validations[:presence_of][:message])
      end
    end
end
