require 'set'

module Rodimus

  module Observable
    def notify(subject, event)
      observers.each do |observer|
        observer.on_notify(subject, event)
      end
    end

    def observers
      @observers ||= Set.new
    end
  end

end
