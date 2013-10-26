# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[2,4].each do |table_size|
  Table.create(seats: table_size)
end

puts 'Tables created'
Table.all.each {|t| puts t.inspect }
