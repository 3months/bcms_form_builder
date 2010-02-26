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
    unless options.is_a?(Array)
      self.item_list = []
      return []
    end

    flattened = options.map do |option|
      parts = [option[:label], option[:value]].delete_if {|part| part.to_s.strip.blank?}
      if parts.length > 0
        [
          parts.length == 2 ? parts.join(';') : [parts.first, parts.first.downcase].join(';'),
          option[:selected] == '1' ? 't' : 'f'
        ].join(';')
      else
        nil
      end
    end.compact
    self.item_list = flattened
  end
  def select_options
    return item_list.map do |o|
      parts = o.split(/;/)
      {:label => parts[0], :value => parts[1], :selected => parts[2] == 't'}
    end
  end

  def check_box_options=(options)
    unless options.is_a?(Array)
      self.item_list = []
      return []
    end

    flattened = options.map do |option|
      parts = [option[:label], option[:value]].delete_if {|part| part.to_s.strip.blank?}
      if parts.length > 0
        [
          parts.length == 2 ? parts.join(';') : [parts.first, parts.first.downcase].join(';'),
          option[:checked] == '1' ? 't' : 'f'
        ].join(';')
      else
        nil
      end
    end.compact
    self.item_list = flattened
  end
  def check_box_options
    return item_list.map do |o|
      parts = o.split(/;/)
      {:label => parts[0], :value => parts[1], :checked => parts[2] == 't'}
    end
  end

  def radio_button_options=(options)
    unless options.is_a?(Array)
      self.item_list = []
      return []
    end

    flattened = options.map do |option|
      parts = [option[:label], option[:value]].delete_if {|part| part.to_s.strip.blank?}
      if parts.length > 0
        [
          parts.length == 2 ? parts.join(';') : [parts.first, parts.first.downcase].join(';'),
          option[:selected] == '1' ? 't' : 'f'
        ].join(';')
      else
        nil
      end
    end.compact
    self.item_list = flattened
  end
  def radio_button_options
    return item_list.map do |o|
      parts = o.split(/;/)
      {:label => parts[0], :value => parts[1], :selected => parts[2] == 't'}
    end
  end

  def class_values=(values)
    self.item_list = [] unless values.is_a?(String)

    self.item_list = values.split(/[\s,]+/)
  end
  def class_values
    return item_list.join(' ')
  end

  def direct_value=(value)
    self.value = value
  end
  def direct_value
    return self.value
  end

  def boolean_value=(value)
    case value
    when true, '1'
      self.value = '1'
    when false, '0'
      self.value = '0'
    else
      self.value = nil
    end
  end
  def boolean_value
    return case self.value
    when '1'
      true
    when '0'
      false
    else
      nil
    end
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
