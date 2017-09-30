class AddAttrToHistoryPoint < ActiveRecord::Migration[5.1]
  def change
    remove_column :lawyer_profiles, :advertise_start_time
    remove_column :lawyer_profiles, :advertise_end_time

    add_column :history_points, :amount, :integer
    add_column :history_points, :total, :integer
  end
end
