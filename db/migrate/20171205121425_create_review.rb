class CreateReview < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :account
      t.references :reviewable, polymorphic: true
      t.string :content
      t.integer :stars

      t.timestamps
    end
  end
end
