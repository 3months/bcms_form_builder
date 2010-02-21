module Cms::CustomFormsHelper

  def hide_if_editing(tag, record, options = {}, &block)
    new_classes = ['to_hide']
    new_classes << 'hidden' unless record.new_record?
    new_classes += options[:class].to_s.split(/\s+/)
    concat("<#{tag.to_s} class=\"#{new_classes.join(' ')}\"", block.binding)
    yield
    concat("</#{tag.to_s}>", block.binding)
  end
  
end
