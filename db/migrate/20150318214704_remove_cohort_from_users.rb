class RemoveCohortFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :cohort_id, :integer
  end
end
