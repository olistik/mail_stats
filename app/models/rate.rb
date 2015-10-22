module Rate
  extend self

  def apply(value:, reference:)
    if reference == 0
      'n/a'
    else
      coerce(value) / coerce(reference)
    end
  end

  private

    def coerce(value)
      BigDecimal.new(value)
    end
end
