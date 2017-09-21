class LawyerProfile < ApplicationRecord
  belongs_to :account
  belongs_to :law_firm, optional: true
  has_many :educations

  LAWYER_PROFILE_ATTRIBUTES = [:full_name, :address, :phone_number, :fax_number, :lawyer_id, :introduction]

  delegate :name, :email, to: :account, prefix: true, allow_nil: true

  def manager_of id
    law_firm_id == id.to_i && is_manager
  end
end
