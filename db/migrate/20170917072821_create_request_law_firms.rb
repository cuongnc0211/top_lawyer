class CreateRequestLawFirms < ActiveRecord::Migration[5.1]
  def change
    create_table :request_law_firms do |t|
      t.references :account
      t.integer :status
      t.references :law_firm

      t.timestamps
    end
  end
end
