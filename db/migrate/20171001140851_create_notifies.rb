class CreateNotifies < ActiveRecord::Migration[5.1]
  def change
    create_table :notifies do |t|
      t.references :account
      t.integer :target_id
      t.references :notifyable, polymorphic: true
      t.integer :action

      t.timestamps
    end
  end
end
