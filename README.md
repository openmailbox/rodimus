# Rodimus

ETL stands for Extract-Transform-Load. Sometimes, you have data in Source A
that needs to be moved to Destination B.  Along the way, it needs to be
manipulated in some way.  This is a common scenario when working with a data
warehouse.  There are lots of ETL solutions in the wild, but very few of them
are open source.  None of them (that I know of) are Ruby.  So, I started
hacking on one for my own use.

__Why the name?__ Rodimus Prime is one of the leaders of the Autobots, and he
has a cool name.  Naming a data transformation library after a Transformer
increases the coolness factor.  It's science.

__NOTE:__ This library is still in the earliest phases of development.  Things
are prone to change suddenly and rapidly.  Use at your own risk.

## Installation

Add this line to your application's Gemfile:

    gem 'rodimus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rodimus

## Usage

See the examples directory for the quickest path to success.

## Contributing

1. Fork it ( http://github.com/nevern02/rodimus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
