require 'rodimus'

class LogInput < Rodimus::Step
  def initialize(file)
    super()
    @incoming = File.new(file)
  end
end
