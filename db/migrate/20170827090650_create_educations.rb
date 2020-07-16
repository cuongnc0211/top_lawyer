class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations do |t|
      t.references :lawyer_profile
      t.integer :degree
      t.string :school
      t.date :start_time
      t.date :end_time
      
      t.timestamps
    end
  end
end
