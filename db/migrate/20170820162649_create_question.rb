class CreateQuestion < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :accounts
      t.string :title
      t.text :content
      t.references :categories

      t.timestamps null: false
    end
  end
end
