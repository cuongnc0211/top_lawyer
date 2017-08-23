class LawyerProfile < ApplicationRecord
  belongs_to :account

  LAWYER_PROFILE_ATTRIBUTES = [:address, :phone_number, :lawyer_id]
end
