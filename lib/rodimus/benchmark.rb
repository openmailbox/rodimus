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
      row_run_time = (Time.now.to_f - @row_start_time).round(4)
      stats[:processing] = (stats[:processing] + row_run_time).round(4)
      stats[:min] = row_run_time if stats[:min] > row_run_time
      stats[:max] = row_run_time if stats[:max] < row_run_time
    end

    def before_row
      stats[:count] += 1
      @row_start_time = Time.now.to_f
    end

    def finalize_stats(subject)
      stats[:total] = (Time.now.to_f - @start_time).round(4)
      if stats[:count] > 0
        stats[:average] = (stats[:processing] / stats[:count]).round(4)
      end

      Rodimus.logger.info(subject) { summary }
    end

    def initialize_stats
      @stats = {count: 0, processing: 0, min: 1, max: 0, average: 0}
      @start_time = Time.now.to_f
    end

    def summary
      <<-EOS 
        \n\t\tTotal time: #{stats[:total]} seconds
        \tTotal time spent processing: #{stats[:processing]} seconds
        \tTotal time spent waiting: #{(stats[:total] - stats[:processing]).round(4)} seconds
        \tTime ratio spent processing: #{(stats[:processing] / stats[:total]).round(4)}
        \tTotal rows processed: #{stats[:count]}
        \tFastest row: #{stats[:min]} seconds
        \tSlowest row: #{stats[:max]} seconds
        \tAverage row: #{stats[:average]} seconds
      EOS
    end
  end

end
