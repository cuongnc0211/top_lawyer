class AddStatusToNotify < ActiveRecord::Migration[5.1]
  def change
    add_column :notifies, :status, :integer
  end
end
