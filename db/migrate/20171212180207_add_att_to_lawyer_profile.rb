class AddAttToLawyerProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :lawyer_profiles, :lawyer_card_image, :string
    add_column :lawyer_profiles, :id_card_image, :string
  end
end
