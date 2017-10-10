class LawyerProfile < ApplicationRecord
  belongs_to :account
  belongs_to :law_firm, optional: true
  has_many :educations
  has_many :add_law_firms

  LAWYER_PROFILE_ATTRIBUTES = [:full_name, :address, :phone_number, :fax_number, :lawyer_id, :introduction]

  delegate :name, :email, :avatar, to: :account, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true
  delegate :total_point, to: :account, prefix: false, allow_nil: true


  def manager_of id
    law_firm_id == id.to_i && is_manager
  end

  def can_out current_law_firm_id
    law_firm_id == current_law_firm_id && !is_manager
  end

  scope :no_law_firm, -> { where(law_firm_id: nil) }
  scope :not_add_law_firm, -> (list_id) {where.not(id: list_id)}
end
