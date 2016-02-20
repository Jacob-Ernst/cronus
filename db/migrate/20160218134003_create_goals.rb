class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.integer :frequency
      t.datetime :deadline
      t.integer :category
      t.decimal :target

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
