Fabricator(:excavator) do
  data do
    {
      "Address" => Faker::Address.full_address,
      "CrewOnSite" => Faker::Boolean.boolean,
      "CompanyName" => Faker::Company.name
    }
  end
  ticket
end
