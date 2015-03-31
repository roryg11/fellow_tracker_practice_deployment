class Cohort < ActiveRecord::Base
  validates :season, :year, :start_date, presence: true
  validate :start_date_is_a_monday
  has_many :users, through: :memberships
  has_many :memberships
  accepts_nested_attributes_for :memberships, :allow_destroy => true
  delegate :fellows, :coaches, :staffs, to: :users

  def full_name
    "#{season} #{year}"
  end

  def first_monday
    launch_phase = start_date + phase_length
    monday = launch_phase.at_beginning_of_week
  end

  def start_date_is_a_monday
    errors.add(:start_date, "must be a monday") if !start_date.monday?
  end

  def phase_length
    7 * 12
  end

  def weeks_elapsed
    (((Date.today - (start_date + phase_length)).to_i)/7.0).ceil
  end

  def overall_progress
    fellow_total = 0
    number_of_fellows = fellows.length
    overall_average = 0
    fellows.each do |fellow|
      fellow_total += fellow.overall_progress
    end
    if number_of_fellows > 0
      overall_average = fellow_total/number_of_fellows
    end
    overall_average
  end

  def current_phase
    if Date.today < start_date + phase_length
      "Voyage Phase"
    elsif Date.today < start_date + (phase_length * 2)
      "Launch Phase"
    elsif Date.today < start_date + (phase_length *3)
      "Internship"
    elsif Date.today < start_date + (phase_length * 4)
      "Project"
    elsif Date.today < start_date
      "Not yet started"
    else
      "Cohort has graduated"
    end
  end

  def weeks_from_start
    ((Date.today - start_date)/7).ceil.to_i
  end

  def week_dates(week_number)
    week_start_date(week_number).strftime("%B %d %Y") + ' - ' + week_end_date(week_number).strftime("%B %d %Y")
  end

  def week_range(week_number)
    week_start_date(week_number)..week_end_date(week_number)
  end

  def week_start_date(week_number)
    start_date + (7 * (week_number - 1))
  end

  def week_end_date(week_number)
    week_start_date(week_number) + 6
  end
end
