module Stats
  extend self

  def emails_sent
    get_counter(label: LabelForEmailEvent.emails_sent)
  end

  def clicks
    get_counter(label: LabelForEmailEvent.clicks)
  end

  def emails_opened
    get_counter(label: LabelForEmailEvent.emails_opened)
  end

  def rates
    email_types.each_with_object({}) do |email_type, memo|
      memo.merge!({
        email_type => rates_for(email_type: email_type)
      })
    end
  end

  private

    def email_types
      $redis.with do |connection|
        connection.smembers LabelForEmailEvent.email_types
      end.sort
    end

    def rates_for(email_type:)
      emails_sent_for(email_type: email_type).pat do |reference|
        {
          click: Rate.apply(
            value: clicks_for(email_type: email_type),
            reference: reference
          ),
          open: Rate.apply(
            value: emails_opened_for(email_type: email_type),
            reference: reference
          ),
        }
      end
    end

    def clicks_for(email_type:)
      get_counter(label: LabelForEmailEvent.clicks_for(email_type: email_type))
    end

    def emails_opened_for(email_type:)
      get_counter(label: LabelForEmailEvent.emails_opened_for(email_type: email_type))
    end

    def emails_sent_for(email_type:)
      get_counter(label: LabelForEmailEvent.emails_sent_for(email_type: email_type))
    end

    def get_counter(label:)
      $redis.with do |connection|
        connection.get label
      end || 0
    end

end
