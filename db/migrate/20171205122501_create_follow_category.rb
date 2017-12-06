class CreateFollowCategory < ActiveRecord::Migration[5.1]
  def change
    create_table :follow_categories do |t|
      t.references :account
      t.references :category
    end
  end
end
