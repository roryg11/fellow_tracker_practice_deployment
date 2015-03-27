class AddNotesToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :notes, :text
  end
end
