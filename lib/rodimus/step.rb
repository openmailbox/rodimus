module Rodimus

  module Step
    # The incoming data stream.  Can be anything that quacks like an IO
    attr_accessor :incoming

    # The outgoing data stream.  Can be anything that quacks like an IO
    attr_accessor :outgoing

    # Shared user-data accessible across all running transformation steps.
    # This is initialized by the Transformation when the step begins to run.
    attr_accessor :shared_data

    attr_reader :benchmark

    def close_descriptors
      [incoming, outgoing].reject(&:nil?).each do |descriptor|
        descriptor.close if descriptor.respond_to?(:close)
      end
    end

    # Override this for custom cleanup functionality.
    def finalize; end

    # Override this for custom output handling functionality per-row.
    def handle_output(transformed_row)
      outgoing.puts(transformed_row)
    end

    # Override this for custom transformation functionality
    def process_row(row)
      row.to_s
    end

    def run
      start_time = Time.now.to_i
      before_run_hooks.each do |hook|
        self.send(hook)
      end
      @benchmark = {count: 0, total: 0, min: 100, max: 0, average: 0}
      Rodimus.logger.info "Running #{self}"
      @row_count = 1
      incoming.each do |row|
        benchmark[:count] += 1
        row_start_time = Time.now.to_f
        transformed_row = process_row(row)
        handle_output(transformed_row)
        Rodimus.logger.info(self) { "#{@row_count} rows processed" } if @row_count % 50000 == 0
        @row_count += 1
        row_run_time = (Time.now.to_f - row_start_time).round(4)
        benchmark[:total] = (benchmark[:total] + row_run_time).round(4)
        benchmark[:min] = row_run_time if benchmark[:min] > row_run_time
        benchmark[:max] = row_run_time if benchmark[:max] < row_run_time
      end
      if benchmark[:count] > 0
        benchmark[:average] = (benchmark[:total] / benchmark[:count]).round(4)
      end
      finalize
      run_time = Time.now.to_i - start_time
      elapsed_hours = run_time / 3600
      remaining_seconds = run_time % 3600
      elapsed_minuntes = remaining_seconds / 60
      elapsed_seconds = remaining_seconds % 60
      after_run_hooks.each do |hook|
        self.send(hook)
      end
      Rodimus.logger.info "Finished #{self} after #{elapsed_hours} hours, #{elapsed_minuntes} minutes, #{elapsed_seconds} seconds."
      Rodimus.logger.info "#{self} benchmarks: #{benchmark}"
    ensure
      close_descriptors
    end

    def to_s
      "#{self.class} connected to input: #{incoming || 'nil'} and output: #{outgoing || 'nil'}"
    end

    private

    def after_row_hooks
      @after_row_hooks ||= Hook.after_row_hooks(self)
    end

    def before_row_hooks
      @before_row_hooks ||= Hook.before_row_hooks(self)
    end

    def after_run_hooks
      @after_run_hooks ||= Hook.after_run_hooks(self)
    end

    def before_run_hooks
      @before_run_hooks ||= Hook.before_run_hooks(self)
    end
  end

end
