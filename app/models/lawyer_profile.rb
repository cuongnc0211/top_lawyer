class LawyerProfile < ApplicationRecord
  belongs_to :account
  belongs_to :law_firm
  has_many :educations

  LAWYER_PROFILE_ATTRIBUTES = [:address, :phone_number, :lawyer_id]

  delegate :name, :email, to: :account, prefix: true, allow_nil: true
end
