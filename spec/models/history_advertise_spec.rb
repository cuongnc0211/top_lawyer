require 'rails_helper'

RSpec.describe HistoryAdvertise, type: :model do
  let!(:account) {FactoryBot.create :account}

  describe "advertise_period" do
    let!(:history_advertise) {HistoryAdvertise.create account_id: account.id,
      start_time: 3.days.ago, end_time: 2.days.ago}
    it do
      expect(history_advertise.advertise_period).to eq 1
    end
  end
end
