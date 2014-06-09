module Rodimus

  class Benchmark
    include Observing

    attr_reader :stats

    def on_notify(subject, event_type)
      case event_type
      when :before_run
        initialize_stats
      when :after_run
        finalize_stats(subject)
      when :before_row
        before_row
      when :after_row
        after_row
      end
    end

    private

    def after_row
      row_run_time = (Time.now.to_f - @start_time).round(4)
      stats[:total] = (stats[:total] + row_run_time).round(4)
      stats[:min] = row_run_time if stats[:min] > row_run_time
      stats[:max] = row_run_time if stats[:max] < row_run_time
    end

    def before_row
      stats[:count] += 1
      @start_time = Time.now.to_f
    end

    def finalize_stats(subject)
      if stats[:count] > 0
        stats[:average] = (stats[:total] / stats[:count]).round(4)
      end

      Rodimus.logger.info "#{subject} benchmarks: #{stats}"
    end

    def initialize_stats
      @stats = {count: 0, total: 0, min: 1, max: 0, average: 0}
    end
  end

end
