class CreateLawFirms < ActiveRecord::Migration[5.1]
  def change
    create_table :law_firms do |t|
      t.string :phone_number
      t.string :fax
      t.string :email
      t.string :address
      t.text :introduction
      t.time :working_start_time
      t.time :working_end_time
      t.references :province

      t.timestamps
    end
  end
end
