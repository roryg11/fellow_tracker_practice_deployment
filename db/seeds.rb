# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

staff = Staff.create!(
  email: 'admin@uncollege.org',
  password: 'abcd1234',
  password_confirmation: 'abcd1234',
)

fellow = Fellow.create!(
  email: 'fellow@uncollege.org',
  password: 'abcd1234',
  password_confirmation: 'abcd1234',
)

cohort = Cohort.create!(
  season: 'Spring',
  year: '2015',
  start_date: Date.parse('2015-03-23')
)

cohort.users << staff
cohort.users << fellow
