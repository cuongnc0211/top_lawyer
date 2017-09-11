class AddFullNameToLawyerProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :lawyer_profiles, :full_name, :string
    add_column :lawyer_profiles, :approved, :boolean
  end
end
