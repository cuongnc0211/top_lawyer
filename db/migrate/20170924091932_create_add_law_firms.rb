class CreateAddLawFirms < ActiveRecord::Migration[5.1]
  def change
    create_table :add_law_firms do |t|
      t.references :lawyer_profile
      t.integer :status
      t.references :law_firm

      t.timestamps
    end
  end
end
