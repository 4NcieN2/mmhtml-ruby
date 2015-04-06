describe(MMHTML::Reflection) do
  let(:document) { MMHTML::Document.new(File.join(File.dirname(__FILE__), 'google.mht')) }

  before(:all) { MMHTML.reset! }

  it('should raise error if document is invalid') { expect { MMHTML::Document.new(invalid_file_path) }.to raise_error(MMHTML::DocumentInvalid) }
  subject { document.elements }
  its(:any?) { should be(true) }
  it('should have a html content') { expect(document.elements.has?('text/html')).to be(true) }
  it('should have an image content') { expect(document.elements.has?('image/gif')).to be(true) }
  it('should retrieve elements by specified matcher') do
    search = document.elements.search('text/html')
    expect(search).to be_an(Array)
    expect(search).not_to be_empty
  end
end
