class AddIsActiveToLawFirm < ActiveRecord::Migration[5.1]
  def change
    add_column :law_firms, :is_active, :boolean, default: false
  end
end
