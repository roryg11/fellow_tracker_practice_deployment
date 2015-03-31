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
