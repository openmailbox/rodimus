# Rodimus
[![Gem Version](https://badge.fury.io/rb/rodimus.svg)](http://badge.fury.io/rb/rodimus) [![Build Status](https://travis-ci.org/nevern02/rodimus.svg?branch=master)](https://travis-ci.org/nevern02/rodimus)

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

tl;dr: See the examples directory for the quickest path to success.

A transformation is an operation that consists of many steps.  Each step may
manipulate the data in some way.  Typically, the first step is reserved for
reading from your data source, and the last step is used to write to the new
destination.  

In Rodimus, you create a transformation object, and then you add
one or more steps to its array of steps.  You typically create steps by writing 
your own classes that include the Rodimus::Step mixin.  When the transformation is
subsequently run, a new process is forked for each step.  All processes are
connected together using pipes except for the first and last steps (those being the
source and destination steps).  Each step then consumes rows of data from its
incoming pipe and performs some operation on it before writing it to the
outgoing pipe.  

There are several methods on the Rodimus::Step mixin that are able to be
overridden for custom processing behavior before, during, or after the each
row is handled.  If those aren't enough, you're also free to manipulate the
input/output objects (i.e. to redirect to standard out).

The Rodimus approach is to provide a minimal, flexible framework upon which
custom ETL solutions can be built.  ETL is complex, and there tend to be many
subtle differences between projects which can make things like establishing
conventions and encouraging code reuse difficult.  Rodimus is an attempt to
codify those things which are probably useful to a majority of ETL projects
with as little overhead as possible.

## Contributing

1. Fork it ( http://github.com/nevern02/rodimus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
