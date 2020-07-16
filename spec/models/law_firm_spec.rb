require 'rails_helper'

RSpec.describe LawFirm, type: :model do
  let!(:law_firm) {FactoryBot.create :law_firm}
  let!(:lawyer_profile) {FactoryBot.create :lawyer_profile}

  describe "in_adding" do
    context "have lawyer in law_firm" do
      let!(:add_law_firm) {AddLawFirm.create lawyer_profile_id: lawyer_profile.id,
        law_firm_id: law_firm.id}
      it do
        expect(law_firm.in_adding).to eq [lawyer_profile.id]
      end
    end

    context "dont have lawyer" do
      it do
        expect(law_firm.in_adding).to eq []
      end
    end
  end
end
