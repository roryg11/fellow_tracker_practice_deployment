class ChangeCohort < ActiveRecord::Migration
  def change
    change_column :cohorts, :start_date, :date
  end
end
