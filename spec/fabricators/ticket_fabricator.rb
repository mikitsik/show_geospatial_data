require "rgeo"

Fabricator(:ticket) do
  data do
    {
      "DateTimes" => {"ResponseDueDateTime" => "2011/07/13 23:59:59"},
      "DigsiteInfo" => {
        "WellKnownText" => faker_polygon
      },
      "RequestType" => "Normal",
      "ServiceArea" => {
        "PrimaryServiceAreaCode" => {"SACode" => "ZZGL103"},
        "AdditionalServiceAreaCodes" => {"SACode" => ["ZZL01", "ZZL02", "ZZL03"]}
      },
      "RequestAction" => "Restake",
      "RequestNumber" => "09252012-00001",
      "SequenceNumber" => "2421"
    }
  end
end

def faker_polygon
  factory = RGeo::Geographic.simple_mercator_factory
  num_points = Faker::Number.between(from: 3, to: 10)
  polygon_coordinates = Array.new(num_points) do
    factory.point(Faker::Number.decimal(l_digits: 8, r_digits: 6).to_f, Faker::Number.decimal(l_digits: 8, r_digits: 6).to_f)
  end
  factory.polygon(factory.linear_ring(polygon_coordinates)).to_s
end
