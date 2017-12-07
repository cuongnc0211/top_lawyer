class ChangeEducation < ActiveRecord::Migration[5.1]
  def change
    remove_column :educations, :school, :string
    add_column :educations, :university_id, :integer
  end
end
