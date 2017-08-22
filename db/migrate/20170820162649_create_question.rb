class CreateQuestion < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :account
      t.string :title
      t.text :content
      t.references :category

      t.timestamps null: false
    end
  end
end
