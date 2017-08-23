class CreateArticle < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
    	t.references :account
      t.string :title
      t.text :content
      t.references :category
      t.integer :status
      t.integer :total_vote

      t.timestamps null: false
    end
  end
end
