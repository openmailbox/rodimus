module Rodimus

  module RuntimeLogging
    attr_reader :start_time

    def before_run_record_time
      @start_time = Time.now.to_i
      Rodimus.logger.info "Running #{self}"
    end

    def after_run_record_time
      run_time = Time.now.to_i - start_time
      remaining_seconds = run_time % 3600
      elapsed_hours = run_time / 3600
      elapsed_minuntes = remaining_seconds / 60
      elapsed_seconds = remaining_seconds % 60

      Rodimus.logger.info "Finished #{self} after #{elapsed_hours} hours, #{elapsed_minuntes} minutes, #{elapsed_seconds} seconds."
    end
  end

end
