class LawyerProfile < ApplicationRecord
  mount_uploader :lawyer_card_image, ImageUploader
  mount_uploader :id_card_image, ImageUploader
  belongs_to :account
  belongs_to :law_firm, optional: true
  has_many :educations
  has_many :add_law_firms
  has_many :reviews, as: :reviewable

  validates :lawyer_id, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true
  # validates :lawyer_card_image, presence: true
  # validates :id_card_image, presence: true

  LAWYER_PROFILE_ATTRIBUTES = [:full_name, :address, :phone_number, :fax_number, :lawyer_id, :introduction]

  delegate :name, :email, :avatar, to: :account, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true
  delegate :total_point, to: :account, prefix: false, allow_nil: true
  delegate :name, to: :law_firm, prefix: true, allow_nil: true

  scope :not_approve, -> {where(approved: false)}
  scope :active, -> {where(is_active?: true)}
  scope :approved, -> {where(approved: true).or(where(approved: nil))}
  scope :no_law_firm, -> { where(law_firm_id: nil) }
  scope :not_add_law_firm, -> (list_id) {where.not(id: list_id)}


  def manager_of id
    law_firm_id == id.to_i && is_manager
  end

  def active?
    approved && is_active?
  end

  def can_out current_law_firm_id
    law_firm_id == current_law_firm_id && !is_manager
  end
end
