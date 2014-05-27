require 'rodimus'

class LogInput
  include Rodimus::Step

  def initialize(file)
    @incoming = File.new(file)
  end
end
