class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :project
      t.integer :group
      t.integer :member
      t.integer :job

      t.timestamps null: false
    end
  end
end
