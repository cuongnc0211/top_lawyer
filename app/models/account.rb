class Account < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  has_one :lawyer_profile
  has_many :questions
  has_many :articles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:Admin, :User, :Lawyer]

  ACCOUNT_ATTRIBUTES = [:name, :email, :avatar]

  def can_register_lawyer
    return true if lawyer_profile.nil? || !lawyer_profile.approved
  end
end
