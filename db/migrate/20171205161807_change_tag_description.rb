class ChangeTagDescription < ActiveRecord::Migration[5.1]
  def change
    change_column :tag_descriptions, :content, :text
  end
end
