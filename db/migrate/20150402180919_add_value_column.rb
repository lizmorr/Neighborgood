class AddValueColumn < ActiveRecord::Migration
  def up
    add_column :votes, :value, :integer
  end

  def down
    remove_column :votes, :value
  end
end
