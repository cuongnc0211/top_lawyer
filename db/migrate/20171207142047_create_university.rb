class CreateUniversity < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string :name
    end
  end
end
