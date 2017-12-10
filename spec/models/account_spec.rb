require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:account) {Account.create(email: "test@test.com", name: "test", password: "123123", password_confirmation: "123123")}

  describe "can_register_lawyer" do
    it do
      expect(account.can_register_lawyer).to eq true
    end
  end

  describe "account_avatar_url" do
    it do
      expect(account.account_avatar_url).to eq Settings.images.default_avatar
    end
  end

  describe "total_point" do
    let!(:point) {Point.create point_per_time: 10}
    let!(:history_points) {HistoryPoint.create point_id: point.id, account_id: account.id, total: 10}
    it do
      expect(account.total_point).to eq 10
    end
  end

  describe "can_join" do
    let!(:law_firm) {LawFirm.create id: 1, name: "test"}
    let!(:lawyer_profile) {LawyerProfile.create account_id: account.id}
    let!(:request_law_firm) {RequestLawFirm.create account_id: account.id, law_firm_id: 2}
    it do
      expect(account.can_join(law_firm, request_law_firm)).to eq true
    end
  end

  describe "own?" do
    let!(:article) {Article.create title: "title", content: "content", account_id: account.id}
    it do
      expect(account.own? article).to eq true
    end
  end

  describe "init_follow_category" do
    let!(:category) {Category.create name: "title"}
    let!(:follow_category) {category.follow_categories.new(account_id: account.id)}
    it do
      expect(account.init_follow_category(category).persisted?).to eq false
    end
  end

  describe "account_active?" do
    it do
      expect(account.account_active?).to eq true
    end
  end

  describe "account_active?" do
    it do
      expect(account.active_for_authentication?).to eq true
    end
  end

  describe "inactive_message" do
    let!(:account) {Account.create(email: "test@test.com", name: "test",
      password: "123123", password_confirmation: "123123", is_active: false)}

    it do
      expect(account.inactive_message).to eq :locked
    end
  end

end
