class AddAttrToLawyerProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :lawyer_profiles, :fax_number, :string
    add_column :lawyer_profiles, :introduction, :text
    add_column :lawyer_profiles, :reputation, :integer
    add_column :lawyer_profiles, :advertise_start_time, :datetime
    add_column :lawyer_profiles, :advertise_end_time, :datetime
    add_column :lawyer_profiles, :law_firm_id, :integer
  end
end
