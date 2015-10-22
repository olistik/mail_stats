class EmailEventsController < ActionController::Metal
  def create
    body_params.pat do |data|
      Rails.logger.debug data
      EmailEventCollector.perform(
        event: data['Event'],
        email_type: data['EmailType']
      )
    end
    self.status = :ok
    self.response_body = ''
  end

  def body_params
    JSON.parse(request.body.read)
  end
end
