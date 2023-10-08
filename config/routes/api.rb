namespace :api, defaults: {format: :json} do
  namespace :v1 do
    post "ticket_excavator/create_ticket_and_excavator", to: "ticket_excavator#create_ticket_and_excavator"
  end
end
