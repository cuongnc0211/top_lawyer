class CreateHistoryPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :history_points do |t|
      t.references :account
      t.references :point

      t.timestamps
    end
  end
end
