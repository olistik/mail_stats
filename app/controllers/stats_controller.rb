class StatsController < ApplicationController
  def index
    @emails_sent = Stats.emails_sent
    @clicks = Stats.clicks
    @emails_opened = Stats.emails_opened
    @rates = Stats.rates
  end
end
