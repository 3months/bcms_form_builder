module FormBuilder
  module Helpers

    # string_to_html_name
    #
    # Downcase the word leaving it snake-cased and with only a-z and 0-9.
    # Needed externally to ActionView, so included from here into ActionView and
    # necessary ActiveRecord models too.
    #
    def string_to_html_name(string)
      return string.to_s.downcase.gsub(/[^_a-z0-9]/, '_').gsub(/_{2,}/, '_').sub(/(^_|_$)/, '')
    end

  end
end

ActionView::Base.send(:include, FormBuilder::Helpers)
