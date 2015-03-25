class CreateMentorshipTable < ActiveRecord::Migration
  def change
    create_table :mentorships do |t|
      t.integer :coach_id
      t.integer :fellow_id

      t.timestamps
    end
  end
end
