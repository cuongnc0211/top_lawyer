class AddAvatarForLawfirm < ActiveRecord::Migration[5.1]
  def change
    add_column :law_firms, :avatar, :string
  end
end
