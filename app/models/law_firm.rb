class LawFirm < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  has_many :lawyer_profiles
  has_many :images, as: :imageable
  belongs_to :province
  has_many :request_law_firms
  has_many :add_law_firms
  has_many :reviews, as: :reviewable
  has_many :accounts, through: :lawyer_profiles

  validates :name, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true

  accepts_nested_attributes_for :images, :reject_if => lambda { |a| a[:picture].blank? }, allow_destroy: true

  LAWFIRM_ATTRIBUTES = [:name, :mail, :address, :province_id, :phone_number, :fax, :working_start_time,
    :working_end_time, :introduction, images_attributes: [:picture]]

  def in_adding
    add_law_firms.pluck(:lawyer_profile_id)
  end

  def lf_avatar_url
    avatar_url(:avatar) || Settings.images.default_avatar
  end
end
