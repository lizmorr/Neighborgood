class AddCountsColumnToReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :votes_count, :integer
  end

  def down
    remove_column :reviews, :votes_count
  end
end
