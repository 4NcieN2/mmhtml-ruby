require 'mMHTML/header'

module MMHTML
  
  class Element

    attr_reader :head, :body

    def initialize(string)
      process_string(string)
    end

    def valid_with?(match)
      return false unless head.valid?
      head.match_any_with?(match)
    end

    def valid?
      head.valid?
    end

    def to_s
      body
    end

    def decode
      @decode ||= body.unpack(MMHTML.formats[head['content-transfer-encoding']]) if MMHTML.formats.key?('content-transfer-encoding')
    end

    alias_method :native, :decode

    private

    def process_string(string)
      head_end = string.index(/\s{2,}/i)
      @head = MMHTML::Header.new(string)
      @body = string.slice(head_end, string.strip.length).to_s
    end

  end

end
