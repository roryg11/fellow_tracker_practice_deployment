class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
        t.string :season
        t.string :year
        t.datetime :start_date
    end
  end
end
