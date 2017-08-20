class CreateArticle < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
    	t.references :accounts
      t.string :title
      t.text :content
      t.references :categories
      t.integer :status
      t.integer :total_vote

      t.timestamps null: false
    end
  end
end
