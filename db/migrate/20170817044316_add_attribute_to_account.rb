class AddAttributeToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :role, :integer
    add_column :accounts, :name, :string
    add_column :accounts, :avatar, :string
  end
end
