require_relative "../support/generators/polygonable"

Fabricator(:ticket) do
  data do
    {
      "DateTimes" => {"ResponseDueDateTime" => "2011/07/13 23:59:59"},
      "DigsiteInfo" => {
        "WellKnownText" => Polygonable.call
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
