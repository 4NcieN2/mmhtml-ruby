require 'mMHTML/element'

module MMHTML

  class Reflection

    attr_reader :elements

    def initialize(string, separator)
      @elements = []
      process_string(string.to_s, separator)
    end

    def any?
      elements.present?
    end

    def each(&block)
      elements.each(&block)
    end

    def has?(match_string)
      search(match_string).present?
    end

    def search(match_string)
      elements.collect { |el| el.valid_with?(match_string) }
    end

    private

    def process_string(string, separator)
      string.split(separator).each do |element|
        next if element.blank?
        element = MMHTML::Element.new(element)
        @elements.push(element) if element.valid?
      end
    end

  end

end
