require 'rails_helper'

RSpec.describe Notify, type: :model do
  describe "noti_content" do
    let!(:account) {FactoryGirl.create :account}
    let!(:notify) {Notify.create action: :up_vote, account: account}
    it do
      expect(notify.noti_content).to eq "NilClass vừa nhận đánh giá hữu ích"
    end
  end
end
