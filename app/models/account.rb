class Account < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  has_one :lawyer_profile
  has_one :law_firm, through: :lawyer_profile
  has_many :notifies, dependent: :destroy
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
  has_many :review_lawfirms
  has_many :follow_categories
  has_many :categories, through: :follow_categories

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:Admin, :User, :Lawyer]

  ACCOUNT_ATTRIBUTES = [:name, :email, :avatar]

  delegate :manager_of, :law_firm_id, :point, :reputation, to: :lawyer_profile, prefix: false, allow_nil: true
  delegate :active?, to: :lawyer_profile, prefix: true, allow_nil: true

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

  def init_follow_category category
    category.follow_categories.find_by(account_id: self.id) || category.follow_categories.new(account_id: self.id)
  end

  def account_active?
    is_active.nil? || is_active
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    account_active? ? super : :locked
  end

  def get_noti number
    notified.order(created_at: :desc).limit(number)
  end

  def new_noti?
    count = notified.order(created_at: :desc).limit(5).where(status: :unread).count
    count > 0
  end
end
