require "rails_helper"

RSpec.describe TicketPresenter do
  subject(:presenter) { described_class.new(ticket) }

  let(:data) do
    {
      "TestKey" => {
        "NestedKey" => ["First", "Second"],
        "AnotherNested" => "Value"
      }
    }
  end

  let(:expected_data) do
    {
      "Test Key" => {
        "Nested Key" => "First, Second",
        "Another Nested" => "Value"
      }
    }
  end

  let(:ticket) { Fabricate(:ticket, data:) }

  it { expect(presenter.data).to eq(expected_data) }
  it { expect(presenter.excavator).to eq(ticket.excavator) }
  it { expect(presenter.created_at).to eq(ticket.created_at) }
end
