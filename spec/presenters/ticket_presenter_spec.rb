require "rails_helper"

RSpec.describe TicketPresenter do
  subject(:presenter) { described_class.new(ticket) }

  let(:ticket) { Fabricate(:ticket) }

  it { expect(presenter.excavator).to eq(ticket.excavator) }
  it { expect(presenter.created_at).to eq(ticket.created_at) }
end
