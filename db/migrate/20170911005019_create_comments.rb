class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :account
      t.text :content
      t.integer :type
      t.integer :parent_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end

    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
