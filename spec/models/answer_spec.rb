require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:account) {FactoryBot.create :account}
  let!(:answer) {Answer.create account_id: account.id, content: "test", question_id: 1}

  describe "init_vote" do
    it do
      expect(answer.init_vote(account.id).persisted?).to eq false
    end
  end

  describe "all_vote_up" do
    it do
      expect(answer.all_vote_up).to eq 0
    end
  end

  describe "all_vote_down" do
    it do
      expect(answer.all_vote_down).to eq 0
    end
  end

  describe "all_vote" do
    it do
      expect(answer.all_vote).to eq 0
    end
  end
end
