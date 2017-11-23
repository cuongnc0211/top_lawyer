class CreateTagDescription < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_descriptions do |t|
      t.references :tag
      t.string :content
      t.references :account

      t.timestamps
    end
  end
end
