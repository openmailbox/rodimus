module Rodimus

  module Observing
    def on_notify(subject, event_type)
      discovered_hooks(event_type).each do |hook|
        self.send(hook)
      end
    end

    private

    def discovered_hooks(matcher)
      methods.grep(/^#{matcher}/)
    end
  end

end
