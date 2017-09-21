class RequestLawFirm < ApplicationRecord
  belongs_to :account
  belongs_to :law_firm

  delegate :name, :id, to: :account, prefix: true, allow_nil: true
end
