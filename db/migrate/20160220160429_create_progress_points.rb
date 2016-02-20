class CreateProgressPoints < ActiveRecord::Migration
  def change
    create_table :progress_points do |t|
      t.decimal :amount, null: false

      t.references :goal, index: true

      t.timestamps null: false
    end
  end
end
