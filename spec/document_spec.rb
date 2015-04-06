describe(MMHTML::Document) do
  let(:document) { MMHTML::Document.new(File.join(File.dirname(__FILE__), 'google.mht')) }
  let(:invalid_file_path) { File.join(File.dirname(__FILE__), 'invalid.mht') }

  before(:all) { MMHTML.reset! }

  it('should raise error if document is invalid') { expect { MMHTML::Document.new(invalid_file_path) }.to raise_error(MMHTML::DocumentInvalid) }
  subject { document }
  its(:valid?) { should be(true) }
  its(:invalid?) { should be(false) }
  it('should have elements') { expect(document.elements.any?).to be(true) }
end
