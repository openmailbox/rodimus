require 'minitest/autorun'
require 'rodimus'

Rodimus.configure do |config|
  config.logger = Logger.new(nil)
end

class TestIO < IO # Because we can't read closed StringIOs
  attr_reader :history

  def initialize
    @history = []
  end

  def close; nil; end

  def puts(string)
    history << string
  end
end
