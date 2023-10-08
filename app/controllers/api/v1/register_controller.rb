class Api::V1::RegisterController < ApplicationController
  def insert_data
  end

  private

  def downcase_key_attrs(attrs)
    attrs.map { |k, v| [k.downcase, v] }.to_h
  end

  def assemble_excavator_attrs(attrs)
    address_keys = [:Address, :City, :State, :Zip]
    address = attrs.extract!(*address_keys).values.join(", ")
    attrs.merge(address:)
  end

  def ticket_params
    params.permit(
      :RequestNumber,
      :SequenceNumber,
      :RequestType,
      :RequestAction,
      DateTimes: [
        :ResponseDueDateTime
      ],
      ServiceArea: [
        PrimaryServiceAreaCode: [
          :SACode
        ],
        AdditionalServiceAreaCodes: [
          SACode: []
        ]
      ]
    ).merge(
      params.require(
        :ExcavationInfo
      ).permit(
        DigsiteInfo: [
          :WellKnownText
        ]
      )
    )
  end

  def excavator_params
    params.require(
      :Excavator
    ).permit(
      :CompanyName,
      :Address,
      :City,
      :State,
      :Zip,
      CrewOnsite: [:boolean]
    )
  end
end
