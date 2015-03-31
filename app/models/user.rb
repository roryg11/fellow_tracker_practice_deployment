class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :goals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :cohorts, through: :memberships
  has_many :memberships
  self.inheritance_column = :role

  def self.roles
    %w(Fellow Coach Staff)
  end

  scope :fellows, -> {where(role: 'Fellow')}
  scope :coaches, -> {where(role: 'Coach')}
  scope :staff, -> {where(role: 'Staff')}

  def fellow?
    role == 'Fellow'
  end

  def cohort_week_array
    if memberships
      cohort_start_date = cohorts[0].start_date
      week_number = 1
      first_monday = cohorts[0].first_monday
      cohort_phase_array = []
      weeks_since_launch = ((Date.today - first_monday)/7).ceil.to_i
      weeks_since_launch.times do
        week_hash = {}
        week_hash[:week_number] = week_number
        week_hash[:start] = (first_monday + (7*(week_number -1))).strftime("%B %d %Y")
        week_hash[:end] = (first_monday + (7*(week_number -1)) + 6).strftime("%B %d %Y")
        week_hash[:goals] = []
        week_hash[:goals] = goals.where(due_date: week_hash[:start]..week_hash[:end])
        if week_hash[:goals].length > 0
          week_hash[:progress] = (((week_hash[:goals].where(completed: true)).length).to_f / (week_hash[:goals].length)) * 100
        end
        cohort_phase_array.push(week_hash)
        week_number+=1
       end
     cohort_phase_array
    end
  end

  def cumulative_progress
    progress = 0
    counter = 0
    cohort_week_array.each do |week|
      if week[:goals].length > 0
        counter += week[:goals].length
        progress += (week[:goals].where(completed: true)).length
      end
    end

    if counter !=0
      (((progress.to_f) / counter) * 100).floor
    else
      0
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
