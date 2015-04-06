class AddImageToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :image, :string
  end
end
