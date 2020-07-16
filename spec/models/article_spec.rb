require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:account) {FactoryBot.create :account}
  let!(:article) {Article.create account_id: account.id, category_id: 1, status: :publish, total_vote: 0}

  describe "init_vote" do
    it do
      expect(article.init_vote(account.id).persisted?).to eq false
    end
  end

  describe "init_clip" do
    it do
      expect(article.init_clip(account.id).persisted?).to eq false
    end
  end

  describe "all_vote_up" do
    it do
      expect(article.all_vote_up).to eq 0
    end
  end

  describe "all_vote_down" do
    it do
      expect(article.all_vote_down).to eq 0
    end
  end

  describe "all_vote" do
    it do
      expect(article.all_vote).to eq 0
    end
  end

  describe "all_tags" do
    it do
      expect(article.all_tags).to eq []
    end
  end
end
