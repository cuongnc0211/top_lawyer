class AddTotalVoteToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :total_vote, :integer
  end
end
