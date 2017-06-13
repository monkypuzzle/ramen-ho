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
30.times do |i|
  name = Faker::Name.first_name
  party_size = [1,2,3,4].sample
  rand_restaurant = [1,2,3].sample
  num_of_parties_before = Waittime.parties_before(rand_restaurant).count
  Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: rand_restaurant, number_of_parties_before: num_of_parties_before)
  sleep 2
end

# Create 10 waittimes (already seated)
30.times do |i|
  name = Faker::Name.first_name
  party_size = [1,2,3,4].sample
  rand_restaurant = [1,2,3][i%3]
  seated_waits = [5, 10, 15, 20, 25, 30, 35, 40 , 45, 45][i%10]
  num_of_parties_before = Waittime.parties_before(rand_restaurant).count
  Waittime.create(seated:true, seated_time: seated_waits, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: rand_restaurant, number_of_parties_before: num_of_parties_before)
  sleep 2
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
Restaurant.create(
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
