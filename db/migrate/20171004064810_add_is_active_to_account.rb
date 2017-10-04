class AddIsActiveToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :is_active, :boolean
  end
end
