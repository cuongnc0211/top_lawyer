class CreateLawyerProfile < ActiveRecord::Migration[5.1]
  def change
    create_table :lawyer_profiles do |t|
      t.references :account
      t.integer :point
      t.string :lawyer_id
      t.string :address
      t.string :phone_number
      t.boolean :is_active
      t.boolean :is_manager

      t.timestamps null: false
    end
  end
end
