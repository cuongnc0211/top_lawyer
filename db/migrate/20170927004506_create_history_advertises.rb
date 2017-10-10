class CreateHistoryAdvertises < ActiveRecord::Migration[5.1]
  def change
    create_table :history_advertises do |t|
      t.references :account
      t.references :category
      t.integer :province_id
      t.references :history_point
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
