class DropTableNeighborhoodsAndRecreate < ActiveRecord::Migration
  def up
    drop_table :neighborhoods
    create_table :neighborhoods do |t|
      t.string :name, null: false, length: { minimum: 4 }
      t.string :location, null: false
      t.text :description
      t.string :image_url
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :neighborhoods, :name, unique: true
  end

  def down
    drop_table :neighborhoods
    create_table :neighborhoods do |t|
      t.string :name, null: false, length: { minimum: 4 }
      t.string :location, null: false
      t.text :description
      t.string :image_url
      t.integer :user_id, null: false
      t.index :name, unique: true

      t.timestamps
    end
  end
end
