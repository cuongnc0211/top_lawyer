class CreateClips < ActiveRecord::Migration[5.1]
  def change
    create_table :clips do |t|
      t.references :account
      t.references :article
      
      t.timestamps
    end
  end
end
