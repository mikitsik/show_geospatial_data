namespace :api, defaults: {format: :json} do
  namespace :v1 do
    post "registers/record_data", to: "registers#record_data"
  end
end
