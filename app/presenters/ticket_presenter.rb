class TicketPresenter
  attr_accessor :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  def data
    transform(
      ticket.data.except("DigsiteInfo")
    )
  end

  def excavator
    ticket.excavator
  end

  def polygon
    RGeo::GeoJSON.encode(
      RGeo::Cartesian.factory.parse_wkt(
        ticket.data["DigsiteInfo"]["WellKnownText"]
      )
    )["coordinates"][0]
  end

  def created_at
    ticket.created_at
  end

  private

  def transform(hash)
    change_item = ->(item) { item.is_a?(Array) ? item.join(", ") : item.gsub(/(?<=[a-z])(?=[A-Z])/, " ") }
    hash.each_with_object({}) do |(key, value), result|
      new_key = change_item.call(key)
      new_value = value.is_a?(Hash) ? transform(value) : change_item.call(value)
      result[new_key] = new_value
    end
  end
end
