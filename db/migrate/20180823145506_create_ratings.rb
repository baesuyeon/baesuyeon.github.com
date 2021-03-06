class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :project, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.float :rating

      t.timestamps null: false
    end
  end
end
