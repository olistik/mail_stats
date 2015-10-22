require 'test_helper'

class EventsCollectionTest < ActionDispatch::IntegrationTest

  def teardown
    $redis.with do |connection|
      connection.flushdb
    end
  end

  test "collect 1 send event" do
    "Foo".pat do |email_type|
      set_initial_state
      post_email_event(event: "send", email_type: email_type)
      assert_response :success
      assert_basic_stats(emails_sent: 1, clicks: 0, emails_opened: 0)
      assert_rates_stats(email_type: email_type, click: 0, open: 0)
    end
  end

  test "collect 1 send event after 1 send event" do
    "Foo".pat do |email_type|
      set_initial_state(email_events: [
        { event: "send", email_type: "Foo" },
      ])
      post_email_event(event: "send", email_type: email_type)
      assert_response :success
      assert_basic_stats(emails_sent: 2, clicks: 0, emails_opened: 0)
      assert_rates_stats(email_type: email_type, click: 0, open: 0)
    end
  end

  test "collect 1 click event after 2 send events" do
    "Foo".pat do |email_type|
      set_initial_state(email_events: [
        { event: "send", email_type: "Foo" },
        { event: "send", email_type: "Foo" },
      ])
      post_email_event(event: "click", email_type: email_type)
      assert_response :success
      assert_basic_stats(emails_sent: 2, clicks: 1, emails_opened: 0)
      assert_rates_stats(email_type: email_type, click: 0.5.to_d, open: 0)
    end
  end

  private

    def set_initial_state(email_events: [])
      email_events.each do |email_event|
        EmailEventCollector.perform(
          event: email_event[:event],
          email_type: email_event[:email_type]
        )
      end
    end

    def assert_basic_stats(emails_sent:, clicks:, emails_opened:)
      assert_equal emails_sent, Stats.emails_sent
      assert_equal clicks, Stats.clicks
      assert_equal emails_opened, Stats.emails_opened
    end

    def assert_rates_stats(email_type:, click:, open:)
      assert_equal click, Stats.rates[email_type][:click]
      assert_equal open, Stats.rates[email_type][:open]
    end

    def post_email_event(event:, email_type:)
      post(
        "/email_events",
        {
          "Event" => event,
          "EmailType" => email_type
        }.to_json,
        "CONTENT_TYPE" => "application/json"
      )
    end
end
