class Mentorship < ActiveRecord::Base
  belongs_to :fellow
  belongs_to :coach
  validates_uniqueness_of :fellow_id
end
