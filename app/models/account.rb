class Account < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  has_one :lawyer_profile
  has_one :law_firm, through: :lawyer_profile
  has_one :notifies, dependent: :destroy
  has_many :notified, class_name: Notify.name, foreign_key: "target_id"

  has_many :questions
  has_many :articles
  has_many :comments
  has_many :request_law_firms
  has_many :votes
  has_many :history_points
  has_many :history_advertises
  has_many :points, through: :history_points
  has_many :last_month_bonus_points, -> {bonus_point.in_last_month}, class_name: "HistoryPoint"
  has_many :unexpired_advertise, -> {unexpired}, class_name: "HistoryAdvertise"
  has_many :answers
  has_many :clips

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:Admin, :User, :Lawyer]

  ACCOUNT_ATTRIBUTES = [:name, :email, :avatar]

  delegate :manager_of, :law_firm_id, :point, :point, to: :lawyer_profile, prefix: false, allow_nil: true

  scope :lawyer, -> {where(role: :Lawyer)}
  scope :active, -> {where(is_active: true)}
  scope :top_lawyer, -> number do
    active.lawyer.left_outer_joins(:last_month_bonus_points)
      .select("#{table_name}.*, SUM(total) AS ranking_point")
      .group("#{table_name}.id")
      .order("ranking_point DESC")
      .limit number
  end

  def self.advertise_lawyer category_id
    accounts = HistoryAdvertise.advertise_lawyer(category_id, Settings.advertise_number.category).pluck(:account_id)
    gap = Settings.advertise_number.category - accounts.length
    if gap > 0
      accounts += Account.top_lawyer(Settings.advertise_number.category).where.not(id: accounts).first(gap).pluck(:id)
    end
    Account.find(accounts)
  end

  def can_register_lawyer
    return true if lawyer_profile.nil? || !lawyer_profile.approved
  end

  def account_avatar_url
    avatar_url(:avatar) || Settings.images.default_avatar
  end

  def can_join law_firm, request_law_firms
    lawyer_profile.present? && law_firm_id.nil? && request_law_firms.law_firm_id != law_firm.id
  end

  def total_point
    history_points.sum :total
  end

  def own? model
    id == model.account_id
  end
end
