describe(MMHTML) do
  let(:my_custom_format) { 'C' }
  let(:my_custom_store_source) { true }

  it('should respond to :configure') { expect { |b| MMHTML.configure(&b) }.to yield_control }
  it('should have default configurations') { expect(MMHTML.config).to be_a(Hash) }
  it('should not store source file data') { expect(MMHTML.config[:store_source]).to be(false) }
  it('should have two default known formats') { expect(MMHTML.config[:formats].keys).to include('quoted-printable', 'base64') }
  it('should be properly configured') do
    MMHTML.configure do |config|
      config[:store_source] = true
      config[:formats]['my_custom_format'] = my_custom_format
    end
    expect(MMHTML.config[:store_source]).to be true
    expect(MMHTML.config[:formats].keys).to include('my_custom_format')
    expect(MMHTML.config[:formats]['my_custom_format']).to eq(my_custom_format)
  end
  it('should respond to :formats') { expect(MMHTML).to respond_to(:formats) }
  it('should be able to reset all configurations') do
    MMHTML.configure do |config|
      config[:store_source] = my_custom_store_source
    end
    expect { MMHTML.reset! }.to change { MMHTML.store_source? }.from(my_custom_store_source).to(!my_custom_store_source)
  end
  it('should respond to :store_source?') { expect(MMHTML).to respond_to(:store_source?) }
end
