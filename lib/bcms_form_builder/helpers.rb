module FormBuilder
  module Helpers
    
    def string_to_html_name(string)
      return string.to_s.downcase.gsub(/[^_a-z0-9]/, '_').gsub(/_{2,}/, '_').sub(/(^_|_$)/, '')
    end

  end
end

ActionView::Base.send(:include, FormBuilder::Helpers)