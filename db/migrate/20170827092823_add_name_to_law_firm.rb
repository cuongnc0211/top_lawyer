class AddNameToLawFirm < ActiveRecord::Migration[5.1]
  def change
    add_column :law_firms, :name, :string
  end
end
