class ChangeDegreeEducation < ActiveRecord::Migration[5.1]
  def change
    change_column :educations, :degree, :integer
  end
end
