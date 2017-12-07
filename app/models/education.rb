class Education < ApplicationRecord
  belongs_to :lawyer_profile
  belongs_to :university

  enum degree: [:bachelor, :master, :doctor]
end
