class HtmlBlockCustomFormElement < CustomFormElement

  @@html_block_config = nil

  def self.config
    return @@html_block_config unless @@html_block_config.nil?

    @@html_block_config = CustomFormElementConfig.new(
      :html_block, 'HTML Block',
      :accessors => {:text => :direct_value, :tag => :direct_value, :classes => :class_values},
      :readers => {:class_array => [:classes, :class_array]}
    )
    @@html_block_config.freeze

    return @@html_block_config
  end

end
