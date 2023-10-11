require "rails_helper"

RSpec.describe TicketsController do
  render_views

  let(:ticket1) { Fabricate(:ticket) }
  let(:ticket2) { Fabricate(:ticket) }

  before do
    Fabricate(:excavator, ticket: ticket1)
    Fabricate(:excavator, ticket: ticket2)
  end

  describe "GET #index" do
    before { get :index, as: :html }

    it { expect(assigns(:tickets)).to match_array([ticket1, ticket2]) }
    it { assigns(:tickets).each { |ticket| expect(ticket.excavator).to be_present } }
    it { expect(response).to render_template(:index) }
    it { expect(response).to be_successful }
  end

  describe "GET #show" do
    before { get :show, params: {id: ticket1.id} }

    it { expect(response).to render_template(:show) }

    context "when the ticket does not exist" do
      it { expect { get :show, params: {id: 0} }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
