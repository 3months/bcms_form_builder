class CheckBoxCustomFormElement < CustomFormElement

  @@check_box_config = nil

  def self.config
    return @@check_box_config unless @@check_box_config.nil?

    @@check_box_config = CustomFormElementConfig.new(
      :check_box,
      'Check Box Input',
      :collecting => true,
<<<<<<< HEAD:app/models/check_box_custom_form_element.rb
      # TODO add 'not blank' style validation to check box set and maximum number checked validation
=======
>>>>>>> 3fd048bcdb84520b748659a1a270fdc92648956b:app/models/check_box_custom_form_element.rb
      :accessors => CONFIG_DEFAULT_ACCESSORS.merge(
        :label => :direct_value,
        :disabled => :boolean_value, # input tag's diabled attribute
        :classes => :class_values,
        :options => :check_box_options
      )#,
      #:readers => {:options_array => [:options, :check_box_options_array], :class_array => [:classes, :class_array]}
    )
    @@check_box_config.freeze

    return @@check_box_config
  end

  # self.print_value
  #
  # Should be a Hash.  If not just #inspect.  If Hash, render as a list of keys.
  #
  def self.print_value(value)
    return value.inspect unless value.is_a?(Hash)

    return value.keys.map {|k| k.inspect}.join(', ')
  end

end
