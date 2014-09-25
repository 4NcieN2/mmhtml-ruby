# MMHTML

[![Code Climate](https://codeclimate.com/repos/5423ee94695680701b0201ce/badges/9ff9085c72fccc21e410/gpa.svg)](https://codeclimate.com/repos/5423ee94695680701b0201ce/feed)  [![Test Coverage](https://codeclimate.com/repos/5423ee94695680701b0201ce/badges/9ff9085c72fccc21e410/coverage.svg)](https://codeclimate.com/repos/5423ee94695680701b0201ce/feed)

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
