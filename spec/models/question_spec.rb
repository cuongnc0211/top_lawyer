require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:account) {FactoryBot.create :account}
  let!(:question) {FactoryBot.create :question}

  describe "init_vote" do
    it do
      expect(question.init_vote(account.id).persisted?).to eq false
    end
  end

  describe "all_vote_up" do
    it do
      expect(question.all_vote_up).to eq 0
    end
  end

  describe "all_vote_down" do
    it do
      expect(question.all_vote_down).to eq 0
    end
  end

  describe "all_vote" do
    it do
      expect(question.all_vote).to eq 0
    end
  end
end
