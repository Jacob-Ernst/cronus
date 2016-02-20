# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'creating test user'
User.create([{ email: 'fake@fake.dev', first_name: 'Test', last_name: 'User', password: 'password' }])
puts 'creating test goal'
Goal.create([{ title: 'Much Test',
               description: 'Such Example Much Awesome',
               frequency: :daily,
               category: :binary,
               target: 10.00,
               user: User.find_by_email('fake@fake.dev') }])
puts 'creating test tag'
Tag.create([{ name: 'doge' }])

puts 'adding test tag to test goal'

seeded_goal = Goal.find_by title: 'Much Test'
seeded_tag = Tag.find_by name: 'doge'
seeded_goal.tags << seeded_tag
seeded_goal.save

puts 'creating test progress point for test goal'
ProgressPoint.create([{ amount: 8.0,
                        goal: seeded_goal }])

