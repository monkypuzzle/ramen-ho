# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create 10 waittimes (currently waiting)
10.times do
  party_size = [1,2,3,4].sample
  Waittime.create(seated:false, party_size: party_size)
  sleep 2
end

# Create 10 waittimes (already seated)
10.times do
  party_size = [1,2,3,4].sample
  Waittime.create(seated:true, party_size: party_size)
  sleep 2
end
