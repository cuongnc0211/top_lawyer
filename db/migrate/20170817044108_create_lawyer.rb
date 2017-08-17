class CreateLawyer < ActiveRecord::Migration[5.1]
  def change
    create_table :lawyers do |t|
      t.references :account
      t.integer :point
      t.boolean :approve
    end
  end
end
