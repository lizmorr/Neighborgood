class AddNotNullConstraintToVotes < ActiveRecord::Migration
  def change
    change_column :votes, :value, :integer, null: false
  end
end
