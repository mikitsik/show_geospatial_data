require "rails_helper"

RSpec.describe Api::V1::TicketExcavatorController do
  describe "POST #create_ticket_and_excavator" do
    def make_request(params)
      post :create_ticket_and_excavator, params: params, as: :json
    end

    let(:params) {
      {
        ContactCenter: "UPCA",
        RequestNumber: "09252012-00001",
        ReferenceRequestNumber: "",
        VersionNumber: "0",
        SequenceNumber: "2421",
        RequestType: "Normal",
        RequestAction: "Restake",
        DateTimes: {
          RequestTakenDateTime: "2011/07/02 23:09:38",
          ResponseDueDateTime: "2011/07/13 23:59:59"
        },
        ServiceArea: {
          PrimaryServiceAreaCode: {
            SACode: "ZZGL103"
          },
          AdditionalServiceAreaCodes: {
            SACode: [
              "ZZL01",
              "ZZL02",
              "ZZL03"
            ]
          }
        },
        Excavator: {
          CompanyName: "John Doe CONSTRUCTION",
          Address: "555 Some RD",
          City: "SOME PARK",
          State: "ZZ",
          Zip: "55555",
          Type: "Excavator",
          Contact: {
            Name: "Johnny Doe"
          },
          CrewOnSite: "true"
        },
        ExcavationInfo: {
          TypeOfWork: "rpr man hole tops",
          DigsiteInfo: {
            LookupBy: "MANUAL",
            WellKnownText: "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))"
          }
        }
      }
    }

    it { expect { make_request(params) }.to change(Ticket, :count).by(1) }
    it { expect { make_request(params) }.to change(Excavator, :count).by(1) }

    context "when polygon is not valid" do
      let(:wrong_params) { {**params, ExcavationInfo: {DigsiteInfo: {WellKnownText: "test"}}} }

      it { expect { make_request(wrong_params) }.to raise_error(StandardError) }
    end
  end
end
