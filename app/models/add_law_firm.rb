class AddLawFirm < ApplicationRecord
  belongs_to :lawyer_profile
  belongs_to :law_firm

  delegate :account_id, :id, :law_firm_id, to: :lawyer_profile, prefix: true, allow_nil: true
  delegate :name, :phone_number, :fax, :email, :address, :introduction, to: :law_firm, prefix: true, allow_nil: true
end
