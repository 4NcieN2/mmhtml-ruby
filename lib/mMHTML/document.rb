require 'open-uri'

require 'mMHTML/reflection'
require 'mMHTML/exception'

module MMHTML
  
  class Document
    attr_reader :content, :file, :head, :elements,
                :boundary, :mark_point, :config

    # Setup data
    def initialize(file_path_or_uri, mark_point = '--')
      file = open(file_path_or_uri).read
      @file = escape_invalid_utf_8_encoding(file)
      @mark_point = mark_point
      setup_info
      process_file
    end

    # Check if current document(element) valid
    def valid?
      head.valid? && head['content-type'].match(/boundary\=(\'|\")[^\1]+\1/i).present?
    end

    # Check if current document(element) invalid
    def invalid?
      !valid?
    end

    private

    def escape_invalid_utf_8_encoding(string, replace = '')
      string.encode("UTF-8", "binary", invalid: :replace, undef: :replace, replace: replace).strip
    end

    def setup_info
      start_index = @file.index("\n#{mark_point}")
      document_invalid!('File empty!') if start_index.blank?
      @head = MMHTML::Header.new(@file.slice(0, start_index).to_s)
      document_invalid!('Invalid document!') if @file.blank? || @head.invalid?
      @boundary = head['content-type'].match(/boundary=(\"|\')([^\1]+)\1/i)[2]
    end

    def process_file
      @elements = MMHTML::Reflection.new(clean_content, start_point)
      @file = nil unless MMHTML.store_source?
    end

    private

    def clean_content
      content_start = @file.index(start_point)
      content_end = @file.index(end_point)
      document_invalid!('No boundary found!') if content_start.blank? || content_end.blank?
      @file.slice(content_start + start_point.length, content_end).gsub(/#{Regexp.escape(end_point)}/i, '').to_s
    end

    def start_point
      "\n#{mark_point}#{boundary}"
    end

    def end_point
      "#{mark_point}#{boundary}#{mark_point}"
    end

    def document_invalid!(message)
      raise MMHTML::DocumentInvalid, message
    end

  end

end
