class RemoveVotesCount < ActiveRecord::Migration
  def up
    remove_column :reviews, :votes_count
  end

  def down
    add_column :reviews, :votes_count, :integer
  end
end
