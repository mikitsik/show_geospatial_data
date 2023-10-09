class Api::V1::TicketExcavatorController < ApplicationController
  def create_ticket_and_excavator
    data = JSON.parse(request.raw_post)
    wkt_polygon = data.dig("ExcavationInfo", "DigsiteInfo", "WellKnownText")
    polygon = RGeo::Cartesian.factory.parse_wkt(wkt_polygon)

    if polygon.valid?
      begin
        Ticket
          .create!(data: ticket_data(data, wkt_polygon))
          .create_excavator!(data: excavator_data(data))
      rescue ActiveRecord::RecordInvalid => e
        render json: {errors: ["Validation failed: #{e.message}"]}, status: :unprocessable_entity
      end
      render json: {message: "Ticket and Excavator created successfully"}, status: :ok
    else
      render json: {errors: [
        StandardError.new("The polygon is not valid").message
      ]}, status: :unprocessable_entity
    end
  end

  private

  def ticket_data(data, wkt_polygon)
    {
      RequestNumber: data["RequestNumber"],
      SequenceNumber: data["SequenceNumber"],
      RequestType: data["RequestType"],
      RequestAction: data["RequestAction"],
      DateTimes: {
        ResponseDueDateTime: data.dig("DateTimes", "ResponseDueDateTime")
      },
      ServiceArea: {
        PrimaryServiceAreaCode: data.dig("ServiceArea", "PrimaryServiceAreaCode"),
        AdditionalServiceAreaCodes: data.dig("ServiceArea", "AdditionalServiceAreaCodes")
      },
      DigsiteInfo: {
        WellKnownText: wkt_polygon
      }
    }
  end

  def excavator_data(data)
    {
      CompanyName: data.dig("Excavator", "CompanyName"),
      Address: excavator_address(data),
      CrewOnSite: data.dig("Excavator", "CrewOnSite")
    }
  end

  def excavator_address(data)
    ["Address", "City", "State", "Zip"].map { |attr| data.dig("Excavator", attr) }.join(", ")
  end
end
