class CreateVote < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :vote_type
      t.references :account
      t.references :voteable, polymorphic: true

      t.timestamps
    end
  end
end
