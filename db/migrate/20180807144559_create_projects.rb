class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :content
      t.string :deadline
      t.integer :numateam
      t.integer :numjob
      t.belongs_to :user, index: true, foreign_key: true
      # t.references :user, index: true, foreign_key: true
      # 이렇게 해도 되고.....
      t.integer :state
      t.integer :aaalll
      t.float :rating
      t.timestamps null: false
    end
  end
end
