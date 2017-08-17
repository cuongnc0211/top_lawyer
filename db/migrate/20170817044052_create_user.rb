class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.references :account
    end
  end
end
