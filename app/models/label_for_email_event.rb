module LabelForEmailEvent
  extend self

  def emails_sent; "email_sent"; end
  def emails_sent_for(email_type:)
    "emails_sent_for_#{email_type}"
  end

  def clicks; "clicks"; end
  def clicks_for(email_type:)
    "clicks_for_#{email_type}"
  end

  def emails_opened; "emails_opened"; end
  def emails_opened_for(email_type:)
    "emails_opened_for_#{email_type}"
  end

  def email_types; "email_types"; end
end
