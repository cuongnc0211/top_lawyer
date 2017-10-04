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
  has_many :answers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:Admin, :User, :Lawyer]

  ACCOUNT_ATTRIBUTES = [:name, :email, :avatar]

  delegate :manager_of, :law_firm_id, :point, :point, to: :lawyer_profile, prefix: false, allow_nil: true
  def can_register_lawyer
    return true if lawyer_profile.nil? || !lawyer_profile.approved
  end

  def account_avatar_url
    avatar_url(:avatar) || Rails.root.join("/images/default-avatar.jpg")
  end

  def can_join law_firm, request_law_firms
    lawyer_profile.present? && law_firm_id.nil? && request_law_firms.law_firm_id != law_firm.id
  end

  def total_point
    history_points.sum :total
  end
end
