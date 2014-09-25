require_relative "spec_helper"

describe(MMHTML::Document) {
  let(:document) {'Content-Type: text/xml
	Content-Transfer-Encoding: quoted-printable
	Content-Location: ./text.xml

	<?xml version=3D"1.0" encoding=3D"UTF-8"?>=0A<note>=0A=09<to>Tove</to>=0A=
	=09<from>Jani</from>=0A=09<heading>Say hi</heading>=0A=09<body>Hello, World=
	!</body>=0A</note>'}
	let(:mhtml) { MMHTML::Document.new(document) }

	it("shoud set source") { expect(mhtml.file).to equal(document) }
	it("sould set be valid") { expect(mhtml.valid?).to equal(true) }
	it("should be xml") { expect(mhtml.content_type).to eq("text/xml") }
	it("should be quoted-printable encoded") { expect(mhtml.content_transfer_encoding).to eq("quoted-printable") }
}
