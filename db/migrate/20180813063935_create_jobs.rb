class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :content
      t.belongs_to :project

      t.timestamps null: false
    end
  end
end
