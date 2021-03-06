class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.belongs_to :project
      
      t.string :team
      t.string :role
      t.integer :one
      t.integer :two
      t.integer :three
      t.integer :four
      t.integer :five
      t.integer :six

      t.float :rating

      t.timestamps null: false
    end
  end
end
