module Percentage
  extend self

  def format(value)
    "#{rounded(value * 100)}%"
  end

  private

    def rounded(value)
      "%.2f" % value
    end
end
