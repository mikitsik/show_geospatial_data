module ControllerHelpers
  def response_json
    @response_json ||= JSON.parse(response.body)
  end
end
