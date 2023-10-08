class Api::V1::RegistersController < ApplicationController
  const TICKET_ATTRS = []

  def insert_data
    data = JSON.parse(request.raw_post)
    ticket_data(data)
    excavator_data(data)
  end

  private

  def ticket_data(data)
    {
      RequestNumber: data[:RequestNumber],
      SequenceNumber: data[:SequenceNumber],
      RequestType: data[:RequestType],
      RequestAction: data[:RequestAction],
      DateTimes: {
        ResponseDueDateTime: data.dig(:DateTimes, :ResponseDueDateTime)
      },
      ServiceArea: {
        PrimaryServiceAreaCode: data.dig(:ServiceArea, :PrimaryServiceAreaCode),
        AdditionalServiceAreaCodes: data.dig(:ServiceArea, :AdditionalServiceAreaCodes)
      },
      ExcavationInfo: {
        DigsiteInfo: {
          WellKnownText: data.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText)
        }
      }
    }
  end

  def excavator_data(data)
    {
      CompanyName: data.dig(:Excavator, :CompanyName),
      Address: excavator_address(data),
      CrewOnSite: data.dig(:Excavator, :CrewOnSite)
    }
  end

  def excavator_address(data)
    [:Address, :City, :State, :Zip].map { |attr| data.dig(:Excavator, attr) }.join(", ")
  end
end
