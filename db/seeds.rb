require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create 1 restaurant
restaurant = Restaurant.create(
  name: "Menya Ultra",
  operating_hours: {
    "sunday": {
      lunch: ["0","0"],
      dinner: ["0", "0"]
    },
    "monday": {
      lunch: ["0","0"],
      dinner: ["0", "0"]
    },
    "tuesday": {
      lunch: ["11:00","14:00"],
      dinner: ["18:00", "21:00"]
    },
    "wednesday": {
      lunch: ["11:00","14:00"],
      dinner: ["18:00", "21:00"]
    },
    "thursday": {
      lunch: ["11:00","14:00"],
      dinner: ["18:00", "21:00"]
    },
    "friday": {
      lunch: ["11:00","14:00"],
      dinner: ["18:00", "21:00"]
    },
    "saturday": {
      lunch: ["11:00","14:00"],
      dinner: ["18:00", "21:00"]
    }
  },
  address: "8199 Clairemont Mesa Blvd Ste M San Diego CA 92111",
  phone: "(858)571-2010"
  )

# Create 1 admin
admin = Admin.create(email: 'menya_ultra@email.com', password: 'password', restaurant_id: 1)

# Create 10 waittimes (currently waiting)
# 30.times do |i|
#   name = Faker::Name.first_name
#   party_size = [1,2,3,4].sample
#   rand_restaurant = [1,2,3].sample
#   Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: rand_restaurant, number_of_parties_before: i)
#   # sleep 2
# end

# # Create 10 waittimes (already seated)
# 30.times do |i|
#   name = Faker::Name.first_name
#   party_size = [1,2,3,4].sample
#   rand_restaurant = [1,2,3][i%3]
#   seated_waits = [5, 10, 15, 20, 25, 30, 35, 40 , 45, 45][i%10]
#   Waittime.create(seated:true, seated_time: seated_waits, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: rand_restaurant, number_of_parties_before: i%3)
#   # sleep 2
# end


# From 6-9p, work through 15 minute intervals

# Extremely busy restaurant.
# 6:00 to 6:15 (1 interval): rate_of_waittime_creation vastly outpaces rate_of_party_seating
# 6:15 to 9:00 (7 intervals): rates are even
i = 0

# i is minutes where 0 is 6:00pm and 180 is 9:00pm
while i < 180
  name = Faker::Name.first_name
  party_size = [1,2,3,4].sample

  num_minutes_between_waittime_creation_events = 6
  num_minutes_between_party_seating_events = 8
  num_parties_before = Waittime.where(seated: false, restaurant_id: 1).length || 0

  # Get minute and hour from i
  hour =  ((60*18) + i)/ 60
  if i < 60 then minute = i end
  if i > 59 && i < 120 then minute = i - 60 end
  if i > 119 then minute = i - 120 end
  puts "#{hour} hours and #{minute} minutes"
  if i < 15
    num_minutes_between_waittime_creation_events = 4
  end

  # If it's the correct minute, create a waittime
  if i % num_minutes_between_waittime_creation_events == 0
    w = Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: 1, number_of_parties_before: num_parties_before)
    w.update(created_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
  end

  # If it's the correct minute, seat the first party
  if i % num_minutes_between_party_seating_events == 0
    party_to_seat = Waittime.where(seated:false, restaurant_id: 1).order(:created_at).first
    party_to_seat.update(seated: true, table_ready: true)
    party_to_seat.update(updated_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
    seated_time = (party_to_seat.updated_at.to_i * 0.0166666666667).to_i - (party_to_seat.created_at.to_i * 0.0166666666667).to_i
    puts seated_time
    party_to_seat.update(seated_time: seated_time)
  end

  if i > 178
    Waittime.where(seated_time: nil).update(seated_time: 0)
  end
  i += 1
end

# Moderately busy restaurant.
# 6:00 to 6:30 (2 intervals): no waittimes
# 6:30 to 7:30 (4 intervals): rate_of_waittime_creation slightly outpaces rate_of_party_seating
# 7:30 to 8:30 (4 intervals): rates are even
# 8:30 to 9:00 (2 intervals):

j = 0

while j < 180
  name = Faker::Name.first_name
  party_size = [1,2,3,4].sample

  num_minutes_between_waittime_creation_events = 8
  num_minutes_between_party_seating_events = 8
  num_parties_before = Waittime.where(seated: false, restaurant_id: 2).length || 0

  # Get minute and hour from i
  hour =  ((60*18) + j)/ 60
  if j < 60 then minute = j end
  if j > 59 && j < 120 then minute = j - 60 end
  if j > 119 then minute = j - 120 end
  puts "#{hour} hours and #{minute} minutes"

  # Adjust rates of waittime_creation and party_seating depending on time (at busier periods, waittime_creation will outpace party_seating)
  if j < 30
    num_minutes_between_waittime_creation_events = 60
    num_minutes_between_party_seating_events = 60
  elsif j > 29 && j < 90
    num_minutes_between_waittime_creation_events = 6
  elsif j > 89 && j < 150
    num_minutes_between_waittime_creation_events = 8
  elsif j > 149 && j < 180
    num_minutes_between_waittime_creation_events = 30
  end

  # If it's the correct minute, create a waittime
  if j % num_minutes_between_waittime_creation_events == 0
    w = Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: 2, number_of_parties_before: num_parties_before)
    w.update(created_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
  end

  # If it's the correct minute, seat the first party
  if j % num_minutes_between_party_seating_events == 0
    party_to_seat = Waittime.where(seated: false, restaurant_id: 2).order(:created_at).first
    if party_to_seat
      party_to_seat.update(seated: true, table_ready: true)
      party_to_seat.update(updated_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
      seated_time = (party_to_seat.updated_at.to_i * 0.0166666666667).to_i - (party_to_seat.created_at.to_i * 0.0166666666667).to_i
      puts seated_time
      party_to_seat.update(seated_time: seated_time)
    end
  end

  if j > 178
    Waittime.where(seated_time: nil).update(seated_time: 0)
  end
  j += 1
end
# 10.times do |i|
#   name = Faker::Name.first_name
#   party_size = [1,2,3,4].sample
#   rand_restaurant = 2
#   seated_waits = [5, 10, 15, 20, 25, 30, 35, 40 , 45, 45][i%10]
#   Waittime.create(seated:true, seated_time: seated_waits, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: rand_restaurant, number_of_parties_before: i)
#   sleep 2
# end
# 10.times do |i|
#   name = Faker::Name.first_name
#   party_size = [1,2,3,4].sample
#   rand_restaurant = 3
#   seated_waits = [5, 10, 15, 20, 25, 30, 35, 40 , 45, 45][i%10]
#   Waittime.create(seated:true, seated_time: seated_waits, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: rand_restaurant, number_of_parties_before: i)
#   sleep 2
# end

# Continue creating restaurants
restaurant2 = Restaurant.create(
  name: "Nozaru Ramen Bar",
  operating_hours: {
    "sunday": {
      lunch: ["12:00","0"],
      dinner: ["0", "22:00"]
    },
    "monday": {
      lunch: ["12:00","0"],
      dinner: ["0", "22:00"]
    },
    "tuesday": {
      lunch: ["12:00","0"],
      dinner: ["0", "22:00"]
    },
    "wednesday": {
      lunch: ["12:00","0"],
      dinner: ["0", "22:00"]
    },
    "thursday": {
      lunch: ["12:00","0"],
      dinner: ["0", "23:00"]
    },
    "friday": {
      lunch: ["12:00","0"],
      dinner: ["0", "24:00"]
    },
    "saturday": {
      lunch: ["12:00","0"],
      dinner: ["0", "24:00"]
    }
  },
  address: "3375 Adams Ave. San Diego CA 92116",
  phone: "(619)564-7183"
  )

admin2 = Admin.create(email: 'nozaru_ramen_bar@email.com', password: 'password', restaurant_id: 2)


Restaurant.create(
  name: "Minato 3",                     ###############################also sushi#################################
  operating_hours: {
    "sunday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    },
    "monday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    },
    "tuesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    },
    "wednesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    },
    "thursday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    },
    "friday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    },
    "saturday": {
      lunch: ["11:00","0"],
      dinner: ["0", "21:30"]
    }
  },
  address: "5420 El Cajon Blvd San Diego CA 92115",
  phone: "(619)452-2857"
  )
Restaurant.create(
  name: "Rakiraki Ramen & Tsukemen",
  operating_hours: {
    "sunday": {
      lunch: ["11:00","0"],
      dinner: ["0", "24:00"]
    },
    "monday": {
      lunch: ["11:00","0"],
      dinner: ["0", "24:00"]
    },
    "tuesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "24:00"]
    },
    "wednesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "24:00"]
    },
    "thursday": {
      lunch: ["11:00","0"],
      dinner: ["0", "02:00"]
    },
    "friday": {
      lunch: ["11:00","0"],
      dinner: ["0", "02:00"]
    },
    "saturday": {
      lunch: ["11:00","0"],
      dinner: ["0", "02:00"]
    }
  },
  address: "4646 Convoy St San Diego CA 92111",
  phone: "(858)573-2400"
  )
Restaurant.create(
  name: "Tajima Ramen House",
  operating_hours: {

    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:30"]
    },
    "monday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:30"]
    },
    "tuesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:30"]
    },
    "wednesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:30"]
    },
    "thursday": {
      lunch: ["11:30","0"],
      dinner: ["0", "02:30"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "02:30"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "02:30"]
    }
  },
  address: "4681 Convoy St Ste I San Diego CA 92111",
  phone: "(858)576-7244"
  )
# Restaurant.create(
#   name: "Nishiki Ramen",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "22:00"]
#     },
#     "monday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "22:00"]
#     },
#     "tuesday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "22:00"]
#     },
#     "wednesday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "22:00"]
#     },
#     "thursday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "22:00"]
#     },
#     "friday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "23:00"]
#     },
#     "saturday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "23:00"]
#     }
#   },
#   address: "8055 Armour St Ste 201A San Diego CA 92111",
#   phone: "(858)987-0222"
#   )
# Restaurant.create(
#   name: "Ramen Yamadaya(Clairemont)",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "monday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:30", "22:00"]
#     },
#     "tuesday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:30", "22:00"]
#     },
#     "wednesday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:30", "22:00"]
#     },
#     "thursday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:30", "22:00"]
#     },
#     "friday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:30", "22:00"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     }
#   },
#   address: "4706 Clairemont Mesa Blvd San Diego CA 92117",
#   phone: "(858)483-3431"
#   )
# Restaurant.create(
#   name: "Wokou Ramen & Yakitori",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "21:00"]
#     },
#     "monday": {
#       lunch: ["0","0"],
#       dinner: ["0", "0"]
#     },
#     "tuesday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "21:00"]
#     },
#     "wednesday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "21:00"]
#     },
#     "thursday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "21:00"]
#     },
#     "friday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "24:00"]
#     },
#     "saturday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "24:00"]
#     }
#   },
#   address: "5965 Village Way Ste e108 San Diego CA 92130",
#   phone: "(858)779-2620"
#   )
# Restaurant.create(
#   name: "Tajima Ramen Hillcrest",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:00"]
#     },
#     "monday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:00"]
#     },
#     "tuesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:00"]
#     },
#     "wednesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:00"]
#     },
#     "thursday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "01:00"]
#     },
#     "friday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "03:00"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "03:00"]
#     }
#   },
#   address: "3739 6th Ave Ste B San Diego CA 92103",
#   phone: "(619)269-5050"
#   )
# Restaurant.create(                              ##########################also pub############################
#   name: "Underbelly",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     },
#     "monday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     },
#     "tuesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     },
#     "wednesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     },
#     "thursday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     },
#     "friday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "24:00"]
#     }
#   },
#   address: "750 W Fir St Ste 101 San Diego CA 92101",
#   phone: "(619)269-4626"
#   )
# Restaurant.create(
#   name: "Hokkaido Ramen Santouka",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     },
#     "monday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     },
#     "tuesday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     },
#     "wednesday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     },
#     "thursday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     },
#     "friday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     },
#     "saturday": {
#       lunch: ["11:00","0"],
#       dinner: ["0", "20:30"]
#     }
#   },
#   address: "4240 Kearny Mesa Rd Mitsuwa Market Pl San Diego CA 92111",
#   phone: "(858)974-1101"
#   )
# Restaurant.create(
#   name: "Yakitori Yakyudori & Ramen",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:30"]
#     },
#     "monday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:30"]
#     },
#     "tuesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:30"]
#     },
#     "wednesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:30"]
#     },
#     "thursday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "23:30"]
#     },
#     "friday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "02:45"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "02:45"]
#     }
#   },
#   address: "4898 Convoy St San Diego CA 92111",
#   phone: "(858)268-2888"
#   )
# Restaurant.create(
#   name: "Izakaya Masa",
#   operating_hours: {
#     "sunday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "monday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "tuesday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "wednesday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "thursday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "friday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "saturday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     }
#   },
#   address: "928 Fort Stockton Dr San Diego CA 92103",
#   phone: "(619)542-1354"
#   )
# Restaurant.create(
#   name: "BeShock Ramen & Sake Bar",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "21:30"]
#     },
#     "monday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "21:30"]
#     },
#     "tuesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "21:30"]
#     },
#     "wednesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "21:30"]
#     },
#     "thursday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "21:30"]
#     },
#     "friday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     }
#   },
#   address: "1288 Market St San Diego CA 92101",
#   phone: "(619)501-9612"
#   )
# Restaurant.create(
#   name: "Rakitori Japanese Pub & Grill",
#   operating_hours: {
#     "sunday": {
#       lunch: ["12:00","0"],
#       dinner: ["0", "23:00"]
#     },
#     "monday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "23:00"]
#     },
#     "tuesday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "23:00"]
#     },
#     "wednesday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "23:00"]
#     },
#     "thursday": {
#       lunch: ["0","0"],
#       dinner: ["16:00", "23:00"]
#     },
#     "friday": {
#       lunch: ["12:00","0"],
#       dinner: ["0", "24:00"]
#     },
#     "saturday": {
#       lunch: ["12:00","0"],
#       dinner: ["0", "24:00"]
#     }
#   },
#   address: "530 University Ave San Diego CA 92103",
#   phone: "(619)501-4091"
#   )
# Restaurant.create(
#   name: "Tajima Ramen East Village",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     },
#     "monday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     },
#     "tuesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     },
#     "wednesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     },
#     "thursday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:30"]
#     },
#     "friday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "03:00"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "03:00"]
#     }
#   },
#   address: "901 E St San Diego CA 92101",
#   phone: "(619)431-5820"
#   )
# Restaurant.create(
#   name: "Tokyo Ramen",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:00", "22:00"]
#     },
#     "monday": {
#       lunch: ["0","0"],
#       dinner: ["0", "0"]
#     },
#     "tuesday": {
#       lunch: ["0","0"],
#       dinner: ["0", "0"]
#     },
#     "wednesday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:00", "22:00"]
#     },
#     "thursday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:00", "22:00"]
#     },
#     "friday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:00", "22:30"]
#     },
#     "saturday": {
#       lunch: ["11:30","15:00"],
#       dinner: ["17:00", "22:30"]
#     }
#   },
#   address: "501 University Ave San Diego CA 92103",
#   phone: "(619)738-8538"
#   )
# Restaurant.create(
#   name: "Ramen Yamadaya(Broadway)",
#   operating_hours: {
#     "sunday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "monday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "tuesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "wednesday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "thursday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "friday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     },
#     "saturday": {
#       lunch: ["11:30","0"],
#       dinner: ["0", "22:00"]
#     }
#   },
#   address: "531 Broadway San Diego CA 92101",
#   phone: "(619)241-2251"
#   )
# Restaurant.create(
#   name: "Donburi Kitchen",
#   operating_hours: {
#     "sunday": {
#       lunch: ["0","0"],
#       dinner: ["0", "0"]
#     },
#     "monday": {
#       lunch: ["11:30","14:30"],
#       dinner: ["17:00", "21:00"]
#     },
#     "tuesday": {
#       lunch: ["11:30","14:30"],
#       dinner: ["17:00", "21:00"]
#     },
#     "wednesday": {
#       lunch: ["11:30","14:30"],
#       dinner: ["17:00", "21:00"]
#     },
#     "thursday": {
#       lunch: ["11:30","14:30"],
#       dinner: ["17:00", "21:00"]
#     },
#     "friday": {
#       lunch: ["11:30","14:30"],
#       dinner: ["17:00", "21:00"]
#     },
#     "saturday": {
#       lunch: ["11:30","14:30"],
#       dinner: ["17:00", "21:00"]
#     }
#   },
#   address: "6030 Santo Rd San Diego CA 92124",
#   phone: "(858)737-4224"
#   )
# Restaurant.create(
#   name: "Ramen Izakaya Ouan",
#   operating_hours: {
#     "sunday": {
#       lunch: ["0","0"],
#       dinner: ["17:30", "21:30"]
#     },
#     "monday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "tuesday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "wednesday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "thursday": {
#       lunch: ["0","0"],
#       dinner: ["18:00", "01:00"]
#     },
#     "friday": {
#       lunch: ["0","0"],
#       dinner: ["17:30", "01:00"]
#     },
#     "saturday": {
#       lunch: ["0","0"],
#       dinner: ["17:30", "01:00"]
#     }
#   },
#   address: "3882 4th Ave San Diego CA 92103",
#   phone: "(619)683-3230"
# )

Restaurant.all.each do |restaurant|
  restaurant.update(number_of_seats: 60)
end
