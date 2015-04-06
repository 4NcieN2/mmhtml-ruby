
# README: MMHTML::Header
#   This class present string as MIME-HTML head in parts
#   Example: head = MMHTML::Header.new('my_mime_html_string')

module MMHTML
  
  class Header

    attr_reader :content

    def initialize(string)
      # PARAMS: string - MIME-HTML string
      @content = { 'message' => '' }
      process_string(string)
    end

    def match_any_with?(*matches)
      match = matches.map { |e| Regexp.escape(e) }.join('|')
      # PARAMS: match - string fragment to match
      @content.values.collect { |el| el.match(/(#{match})/i) }.present?
    end

    def at(key)
      # PARAMS: key - header key to retrieve
      content[key.downcase]
    end

    alias_method :[], :at

    def has?(key)
      # PARAMS: key - header key to check
      content[key].present?
    end

    def valid?
      content.key?('content-type')
    end

    def invalid?
      !valid?
    end

    private

    def process_string(string)
      parts = string.strip.split("\n")
      while parts.present?
        row = parts.shift
        break if row.blank? && row[0].blank? && row[0].match(/^[a-z\-]+\:/).blank?
        head = row.split(':')
        @content[head.shift.strip.downcase] = head.join(':')
      end
      @content['message'] = parts.flatten.join("\n").strip if parts.present? && parts.is_a?(Array)
    end

  end

end
