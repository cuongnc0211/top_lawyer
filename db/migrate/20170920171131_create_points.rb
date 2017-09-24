class CreatePoints < ActiveRecord::Migration[5.1]
  def change
    create_table :points do |t|
      t.integer :option
      t.integer :point_per_time

      t.timestamps
    end
  end
end
