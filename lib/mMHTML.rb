require "rubygems"
require "mMHTML/version"
require 'digest/md5'
require "open-uri"

module MMHTML
	def self.parse filename_or_uri
		Parser.new(filename_or_uri)
	end
	# MHTML element object
	class Document
		attr_reader	:content_type, :content_transfer_encoding, :content_location, :content, :file

		FORMATS = {
			"quoted-printable"	=> "M",
			"base64"	=> "m"
		}
		# Setup data
		def initialize string
			@file = string
			@content_type = ""
			@content_transfer_encoding = ""
			@content_location = ""
			@content = ""
			setup_data(string)
		end
		# Chak if current document(element) valid
		def valid?
			return true unless content_type.empty? && content_transfer_encoding.empty? && content_location.empty?
			false
		end
		# Setup headers and cleaned content
		def setup_data(string)
			@content_type = string.match(/Content-Type:([^\n]*)/i)[1].strip if string.match(/Content-Type/i)
			@content_transfer_encoding = string.match(/Content-Transfer-Encoding:([^\n]*)/i)[1].strip if string.match(/Content-Transfer-Encoding/i)
			@content_location = string.match(/Content-Location:([^\n]*)/i)[1].strip if string.match(/Content-Location/i)
			@content = string.gsub(/(Content-Type:[^\n]*|Content-Transfer-Encoding:[^\n]*|Content-Location:[^\n]*)/i, "")
		end
		# Normalize content from Content-transfer-encoding to to normal
		def normilize_content
			@content = @content.unpack(FORMATS[content_transfer_encoding]) if FORMATS.has_key?(content_transfer_encoding)
			@content
		end
	end
	# MHTML parse
	class Parser
		attr_reader	:boundary, :params, :content, :elements, :file

		MARK_POINT = "--"

		def initialize filename_or_uri
			@file = escape_invalid_utf_8_encoding(open(filename_or_uri).read).strip
			@boundary = retrieve_boundary(@file)
			raise "Invalid file. Unable to locate boundary or start/end data point." if invalid?
			clean_file_from_boundary(boundary)
			@params = retrieve_params(sub_head(@file, start_pointer))
			from = @file.index(start_pointer)
			to = @file.index(end_pointer) - end_pointer.length
			@content = @file[from,to]
			@elements = retrieve_elements(@content, start_pointer)
		end

		def invalid?
			boundary.empty? || !@file.scan(/#{Regexp.escape(start_pointer)}/) || !@file.scan(/#{Regexp.escape(end_pointer)}/)
		end

		def start_pointer
			"#{MARK_POINT}#{boundary}"
		end

		def end_pointer
			"#{MARK_POINT}#{boundary}#{MARK_POINT}"
		end

		def retrieve_elements content, boundary
			elements = []
			content.split(boundary).each { |el|
				el = el.strip
				unless el.empty?
					document = Document.new(el)
					elements.push(document) if document.valid?
				end
			}
			elements
		end

		def retrieve_boundary file
			file.strip.match(/boundary="([^"]*)"/i)[1]
		rescue	=> pe
			""
		end

		def sub_head file, boundary
			file[0,file.index(boundary)]
		end

		def retrieve_params(string)
			params = {}
			params[:content_type] = string.match(/Content-Type:([^;]+)/i)[1].strip
			string.gsub!(/Content-Type:([^;]+)/i, "").gsub!(/|[\r\n]+/, "\n")
			params[:commit] = string.strip
			params
		end
		def proccess_file file, start_point, end_point
			current = Array.new
			blocks = Array.new
			File.readlines(file).each { |line|
				raw = line.encode("UTF-8", "binary", invalid: :replace, undef: :replace, replace: "").strip
				if raw.strip.match(/start_point/i)
					current.shift
					blocks.push(current)
					current = Array.new
				else
					current.push(raw)
				end
				if raw.match(/end_point/i)
					current.shift
					blocks.push(current)
					break
				end
			}
			blocks
		end

		def search content_type
			elements.select { |e| e unless e.content_type.index(content_type).nil? }
		end

		def clean_file_from_boundary boundary
			file.gsub!(/boundary="#{Regexp.escape(boundary)}"/i, "")
		end
		def escape_invalid_utf_8_encoding string, replace = ""
			string.encode("UTF-8", "binary", invalid: :replace, undef: :replace, replace: replace).strip
		end
	end
end