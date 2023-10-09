require "rails_helper"

RSpec.describe TicketsController do
  render_views

  describe "GET #index" do
    let!(:ticket) { Fabricate(:ticket) }
    let!(:excavator) { Fabricate(:excavator, ticket:) }

    it "d" do
      debugger
    end
  end
end
