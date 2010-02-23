class CustomFormElementAttribute < ActiveRecord::Base

  belongs_to :custom_form_element


  def self.build_input_attributes(attribute_hash, config)
    attributes = []
    attribute_hash.each do |k, v|
      next unless action = config.accessor_method(k.intern)

      attributes << build_input_attribute(k, v, action)
    end

    return attributes
  end

  def self.build_input_attribute(key, value, action)
    logger.debug("Assigning action #{value} to attribute #{action}")
    return new(:key => key, action => value)
  end

  def select_options=(options)
    self.item_list = [] unless options.is_a?(String)

    lines = options.map {|s| s.chomp}
    flattened = lines.map do |o|
      parts = o.split(/\s*\|\s*/)
      parts.length == 2 ? parts.join(';') : [parts.first, parts.first.downcase].join(';')
    end
    self.item_list = flattened
  end
  def select_options
    return item_list.map do |o|
      parts = o.split(/;/)
      if parts.length == 2
        [parts.first, parts.last].join('|')
      else
        [parts.first, parts.first].join('|')
      end
    end.join("\n")
  end
  def select_options_array
    return item_list.map do |o|
      parts = o.split(/;/)
      if parts.length == 2
        [parts.first, parts.last]
      else
        [parts.first, parts.first]
      end
    end
  end

  def check_box_options=(options)
    self.item_list = [] unless options.is_a?(String)

    lines = options.map {|s| s.chomp}
    flattened = lines.map do |o|
      parts = o.split(/\s*\|\s*/)
      parts.length == 2 ? "#{parts.first == 't' ? 't' : 'f'};#{parts.last}" : "f;#{parts.first}"
    end
    self.item_list = flattened
  end
  def check_box_options
    return item_list.map do |o|
      parts = o.split(/;/)
      if parts.length == 1
        parts.first
      else
        parts.first == 't' ? "t|#{parts.last}" : "f|#{parts.last}"
      end
    end.join("\n")
  end
  def check_box_options_array
    return item_list.map do |o|
      parts = o.split(/;/)
      if parts.length == 1
        [false, parts.first]
      else
        parts.first == 't' ? [true, parts.last] : [false, parts.last]
      end
    end
  end

  def radio_button_options=(options)
    self.item_list = [] unless options.is_a?(String)

    lines = options.map {|s| s.chomp}
    flattened = lines.map do |o|
      parts = o.split(/\s*\|\s*/)
      parts.length == 2 ? "#{parts.first == 't' ? 't' : 'f'};#{parts.last}" : "f;#{parts.first}"
    end
    self.item_list = flattened
  end
  def radio_button_options
    return item_list.map do |o|
      parts = o.split(/;/)
      if parts.length == 1
        parts.first
      else
        parts.first == 't' ? "t|#{parts.last}" : "#{parts.last}"
      end
    end.join("\n")
  end
  def radio_button_options_array
    return item_list.map do |o|
      parts = o.split(/;/)
      if parts.length == 1
        [false, parts.first]
      else
        parts.first == 't' ? [true, parts.last] : [false, parts.last]
      end
    end
  end

  def class_values=(values)
    self.item_list = [] unless values.is_a?(String)

    self.item_list = values.split(/[\s,]+/)
  end
  def class_values
    return item_list.join(', ')
  end
  def class_array
    return item_list
  end

  def direct_value=(value)
    self.value = value
  end
  def direct_value
    return self.value
  end

  private

    def item_list=(array)
      self.value = nil unless array.length > 0

      self.value = array.join(';;')
    end
    def item_list
      return [] unless self.value.is_a?(String)

      return self.value.split(/;;/)
    end

end
