require 'rails_helper'

RSpec.describe LawyerProfile, type: :model do
  let!(:law_firm) {FactoryBot.create :law_firm}
  let!(:lawyer_profile) {FactoryBot.create :lawyer_profile, law_firm: law_firm, is_manager: true}

  describe "manager_of" do
    it do
      expect(lawyer_profile.manager_of law_firm.id).to eq true
    end
  end

  describe "can_out" do
    let!(:lawyer_profile) {FactoryBot.create :lawyer_profile, law_firm: law_firm, is_manager: false}
    it do
      expect(lawyer_profile.can_out law_firm.id).to eq true
    end
  end
end
