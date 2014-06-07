module Rodimus

  module Hookable
    def discovered_hooks(matcher)
      methods.grep(/^#{matcher}/)
    end
  end

end
