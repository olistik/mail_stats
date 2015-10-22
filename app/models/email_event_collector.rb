module EmailEventCollector
  extend self

  def perform(event:, email_type:)
    case event
    when "send"
      increment_counter(label: LabelForEmailEvent.emails_sent)
      increment_counter(label: LabelForEmailEvent.emails_sent_for(email_type: email_type))
    when "click"
      increment_counter(label: LabelForEmailEvent.clicks)
      increment_counter(label: LabelForEmailEvent.clicks_for(email_type: email_type))
    when "open"
      increment_counter(label: LabelForEmailEvent.emails_opened)
      increment_counter(label: LabelForEmailEvent.emails_opened_for(email_type: email_type))
    end

    $redis.with do |connection|
      connection.sadd LabelForEmailEvent.email_types, email_type
    end
  end

  private

    def increment_counter(label:)
      $redis.with do |connection|
        connection.incr label
      end
    end

end
