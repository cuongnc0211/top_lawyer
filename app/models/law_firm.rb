class LawFirm < ApplicationRecord
  has_many :lawyer_profiles
  belongs_to :province
end
