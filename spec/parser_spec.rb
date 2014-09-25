require_relative "spec_helper"

describe(MMHTML::Parser) {
	let(:filename) { "#{File.dirname(__FILE__)}/google.mht" }
	
	it("shoud read file without raise error") { expect { MMHTML.parse(filename) }.to_not raise_error }
	it("shoud be valid file") { expect(MMHTML.parse(filename).invalid?).to eq(false) }
	it("boundaruy should not be empty") { expect(MMHTML.parse(filename).boundary.empty?).to eq(false) }
	it("params should not be empty") { expect(MMHTML.parse(filename).params.empty?).to eq(false) }
	it("content should not be empty") { expect(MMHTML.parse(filename).content.empty?).to eq(false) }
	it("elements should not be empty") { expect(MMHTML.parse(filename).elements.empty?).to eq(false) }
	it("file should not be empty") { expect(MMHTML.parse(filename).file.empty?).to be(false) }
	it("elements should be array") { expect(MMHTML.parse(filename).elements).to be_kind_of(Array) }
	it("should give correct start point") { expect(MMHTML.parse(filename).start_pointer).to match(/^#{Regexp.escape(MMHTML::Parser::MARK_POINT)}[^\n]+/i) }
	it("should give correct end point") { expect(MMHTML.parse(filename).end_pointer).to match(/^#{Regexp.escape(MMHTML::Parser::MARK_POINT)}[^\n]+#{Regexp.escape(MMHTML::Parser::MARK_POINT)}$/i) }
	it("should correct search elements") { expect(MMHTML.parse(filename).search("html").count).to eq(1) }
}
