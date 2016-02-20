class GoalsTags < ActiveRecord::Migration
  def change
    create_join_table :goals, :tags
  end
end
