# MMHTML

[![Code Climate](https://codeclimate.com/repos/5423f8e16956802797004876/badges/aff6f1456d4f222f45ca/gpa.svg)](https://codeclimate.com/repos/5423f8e16956802797004876/feed)  [![Test Coverage](https://codeclimate.com/repos/5423f8e16956802797004876/badges/aff6f1456d4f222f45ca/coverage.svg)](https://codeclimate.com/repos/5423f8e16956802797004876/feed)  [![Build Status](https://travis-ci.org/4NcieN2/mmhtml-ruby.svg?branch=master)](https://travis-ci.org/4NcieN2/mmhtml-ruby)

## Installation

Add this line to your application's Gemfile:

    gem 'mMHTML'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mMHTML

## Usage
>		mmhtml = MMHTML.parse( filename_or_uri )
	
	Retrieve elements
>		content_type_elements = mmhtml.search( "content_type" )

	Check if valid
>		content_type_elements.first.valid?
		
	Normalize content from 'content-transfer-encoding'
>		content_type_elements.first.normilize_content
			
## Contributing

1. Fork it ( https://github.com/[my-github-username]/mMHTML/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
