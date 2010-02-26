# TODO Document/comment me please - I forget what I was built for!!
class CustomFormElementConfig

  attr_reader :name, :display_name
  attr_reader :validations
  attr_reader :collecting

  def initialize(name, display_name, options = {})
    @name = name
    @display_name = display_name
    @accessors = {}
    @readers = {}
    @validations = {}
    @collecting = !!options[:collecting]

    if options[:accessors]
      self.accessors = options[:accessors]
    end
    if options[:readers]
      self.readers = options[:readers]
    end
    if options[:validations]
      @validations = options[:validations]
    end
  end

  def accessors=(values)
    values.each do |key, details|
      if details.is_a?(Array)
        set_accessor(key, *details)
      else
        set_accessor(key, key, details)
      end
    end
  end
  def accessors
    return @accessors.keys
  end
  def set_accessor(key, db_key, rw_method)
    @accessors[key] = [db_key, rw_method]
  end
  def accessor(key)
    return @accessors[key]
  end
  def accessor_db_key(key)
    return nil unless tmp_accessor = accessor(key)
    return tmp_accessor.first
  end
  def accessor_method(key)
    return nil unless tmp_accessor = accessor(key)
    return tmp_accessor.last
  end

  def readers=(values)
    values.each do |key, details|
      if details.is_a?(Array)
        set_reader(key, *details)
      else
        set_reader(key, key, details)
      end
    end
  end
  def readers
    return @readers.keys
  end
  def set_reader(key, db_key, r_method)
    @readers[key] = [db_key, r_method]
  end
  def reader(key)
    return @readers[key]
  end
  def reader_db_key(key)
    return nil unless tmp_reader = reader(key)
    return tmp_reader.first
  end
  def reader_method(key)
    return nil unless tmp_reader = reader(key)
    return tmp_reader.last
  end
  
end
