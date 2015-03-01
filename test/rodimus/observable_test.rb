require 'test_helper'

class TestObservable < MiniTest::Unit::TestCase
  def setup
    @fake_observer = Class.new do
      attr_reader :subject, :event_type

      def on_notify(subject, event_type)
        @subject = subject
        @event_type = event_type
      end
    end.new
    @subject = Object.new.extend(Rodimus::Observable)
    @subject.observers << @fake_observer
  end

  def test_observer_notification
    @subject.notify(@subject, :test_event)
    assert_equal @fake_observer.subject, @subject
    assert_equal @fake_observer.event_type, :test_event
  end
end
