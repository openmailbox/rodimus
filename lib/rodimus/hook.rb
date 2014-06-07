module Rodimus

  module Hook
    def self.after_run_hooks(hookable)
      hookable.methods.grep(/^after_run_/)
    end

    def self.before_run_hooks(hookable)
      hookable.methods.grep(/^before_run_/)
    end

    def self.before_row_hooks(hookable)
      hookable.methods.grep(/^before_row/)
    end

    def self.after_row_hooks(hookable)
      hookable.methods.grep(/^after_row/)
    end
  end

end
