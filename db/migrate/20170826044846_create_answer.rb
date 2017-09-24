class CreateAnswer < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :account
      t.references :question
      t.text :content
      t.integer :total_vote

      t.timestamps null: false
    end
  end
end
