require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

restaurants = []

restaurants << Restaurant.create(
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
  phone: "(858)571-2010",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13409.976953633277!2d-117.147078!3d32.8321633!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x2f8e0d276b57b5fb!2sMenya+Ultra!5e0!3m2!1sen!2sus!4v1497466329118' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )

# # Create 1 admin
# admin = Admin.create(email: 'menya_ultra@email.com', password: 'password', restaurant_id: 1)

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

# i is minutes where 0 is 6:00pm and 180 is 9:00pm

# i = 0
# while i < 180
#   name = Faker::Name.first_name
#   party_size = [1,2,3,4].sample

#   num_minutes_between_waittime_creation_events = 6
#   num_minutes_between_party_seating_events = 8
#   num_parties_before = Waittime.where(seated: false, restaurant_id: 1).length || 0

#   # Get minute and hour from i
#   hour =  ((60*18) + i)/ 60
#   if i < 60 then minute = i end
#   if i > 59 && i < 120 then minute = i - 60 end
#   if i > 119 then minute = i - 120 end
#   puts "#{hour} hours and #{minute} minutes"
#   if i < 15
#     num_minutes_between_waittime_creation_events = 4
#   end

#   # If it's the correct minute, create a waittime
#   if i % num_minutes_between_waittime_creation_events == 0
#     w = Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: 1, number_of_parties_before: num_parties_before)
#     w.update(created_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
#   end

#   # If it's the correct minute, seat the first party
#   if i % num_minutes_between_party_seating_events == 0
#     party_to_seat = Waittime.where(seated:false, restaurant_id: 1).order(:created_at).first
#     party_to_seat.update(seated: true, table_ready: true)
#     party_to_seat.update(updated_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
#     seated_time = (party_to_seat.updated_at.to_i * 0.0166666666667).to_i - (party_to_seat.created_at.to_i * 0.0166666666667).to_i
#     puts seated_time
#     party_to_seat.update(seated_time: seated_time)
#   end

#   if i > 178
#     Waittime.where(seated_time: nil).update(seated_time: 0)
#   end
#   i += 1
# end

# Moderately busy restaurant.
# 6:00 to 6:30 (2 intervals): no waittimes
# 6:30 to 7:30 (4 intervals): rate_of_waittime_creation slightly outpaces rate_of_party_seating
# 7:30 to 8:30 (4 intervals): rates are even
# 8:30 to 9:00 (2 intervals):

# j = 0

# while j < 180
#   name = Faker::Name.first_name
#   party_size = [1,2,3,4].sample

#   num_minutes_between_waittime_creation_events = 8
#   num_minutes_between_party_seating_events = 8
#   num_parties_before = Waittime.where(seated: false, restaurant_id: 2).length || 0

#   # Get minute and hour from i
#   hour =  ((60*18) + j)/ 60
#   if j < 60 then minute = j end
#   if j > 59 && j < 120 then minute = j - 60 end
#   if j > 119 then minute = j - 120 end
#   puts "#{hour} hours and #{minute} minutes"

#   # Adjust rates of waittime_creation and party_seating depending on time (at busier periods, waittime_creation will outpace party_seating)
#   if j < 30
#     num_minutes_between_waittime_creation_events = 60
#     num_minutes_between_party_seating_events = 60
#   elsif j > 29 && j < 90
#     num_minutes_between_waittime_creation_events = 6
#   elsif j > 89 && j < 150
#     num_minutes_between_waittime_creation_events = 8
#   elsif j > 149 && j < 180
#     num_minutes_between_waittime_creation_events = 30
#   end

#   # If it's the correct minute, create a waittime
#   if j % num_minutes_between_waittime_creation_events == 0
#     w = Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: 2, number_of_parties_before: num_parties_before)
#     w.update(created_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
#   end

#   # If it's the correct minute, seat the first party
#   if j % num_minutes_between_party_seating_events == 0
#     party_to_seat = Waittime.where(seated: false, restaurant_id: 2).order(:created_at).first
#     if party_to_seat
#       party_to_seat.update(seated: true, table_ready: true)
#       party_to_seat.update(updated_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
#       seated_time = (party_to_seat.updated_at.to_i * 0.0166666666667).to_i - (party_to_seat.created_at.to_i * 0.0166666666667).to_i
#       puts seated_time
#       party_to_seat.update(seated_time: seated_time)
#     end
#   end

#   if j > 178
#     Waittime.where(seated_time: nil).update(seated_time: 0)
#   end
#   j += 1
# end

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
restaurants << Restaurant.create(
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
  phone: "(619)564-7183",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13420.380314140792!2d-117.1212672!3d32.7632116!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x8ac157080267c7e6!2sNozaru+Ramen+Bar!5e0!3m2!1sen!2sus!4v1497466435378' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )

restaurants << Restaurant.create(
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
  phone: "(619)452-2857",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13421.144970746629!2d-117.0786757!3d32.7581385!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x4c568fe5b592efa0!2sMinato+3+Ramen+%26+Sushi!5e0!3m2!1sen!2sus!4v1497466513273' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
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
  phone: "(858)573-2400",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13411.106663917599!2d-117.1554755!3d32.824682!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x1023e5e70149c37c!2sRakiraki+Ramen+%26+Tsukemen!5e0!3m2!1sen!2sus!4v1497466658005' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
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
  phone: "(858)576-7244",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13410.976872039111!2d-117.1543696!3d32.8255416!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x8d16a887f2702d3f!2sTajima+Japanese+Restaurant!5e0!3m2!1sen!2sus!4v1497466756101' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Nishiki Ramen",
  operating_hours: {
    "sunday": {
      lunch: ["11:00","0"],
      dinner: ["0", "22:00"]
    },
    "monday": {
      lunch: ["11:00","0"],
      dinner: ["0", "22:00"]
    },
    "tuesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "22:00"]
    },
    "wednesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "22:00"]
    },
    "thursday": {
      lunch: ["11:00","0"],
      dinner: ["0", "22:00"]
    },
    "friday": {
      lunch: ["11:00","0"],
      dinner: ["0", "23:00"]
    },
    "saturday": {
      lunch: ["11:00","0"],
      dinner: ["0", "23:00"]
    }
  },
  address: "8055 Armour St Ste 201A San Diego CA 92111",
  phone: "(858)987-0222",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13411.861272317554!2d-117.1501556!3d32.8196839!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xf026a1068378b728!2sNishiki+Ramen!5e0!3m2!1sen!2sus!4v1497466978275' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Ramen Yamadaya(Clairemont)",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "monday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:30", "22:00"]
    },
    "tuesday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:30", "22:00"]
    },
    "wednesday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:30", "22:00"]
    },
    "thursday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:30", "22:00"]
    },
    "friday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:30", "22:00"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    }
  },
  address: "4706 Clairemont Mesa Blvd San Diego CA 92117",
  phone: "(858)483-3431",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13409.473853733507!2d-117.1892196!3d32.8354945!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xbdb6ae038379628c!2sRamen+Yamadaya!5e0!3m2!1sen!2sus!4v1497467019276' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Below restaurant is breaking the app!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# restaurants << Restaurant.create(
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
restaurants << Restaurant.create(
  name: "Tajima Ramen Hillcrest",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:00"]
    },
    "monday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:00"]
    },
    "tuesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:00"]
    },
    "wednesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:00"]
    },
    "thursday": {
      lunch: ["11:30","0"],
      dinner: ["0", "01:00"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "03:00"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "03:00"]
    }
  },
  address: "3739 6th Ave Ste B San Diego CA 92103",
  phone: "(619)269-5050",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13422.98258902111!2d-117.1592571!3d32.745944!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x34cc2f1d3eae5594!2sTajima+Ramen+Bar+Hillcrest!5e0!3m2!1sen!2sus!4v1497467076490' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(                              ##########################also pub############################
  name: "Underbelly",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    },
    "monday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    },
    "tuesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    },
    "wednesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    },
    "thursday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "24:00"]
    }
  },
  address: "750 W Fir St Ste 101 San Diego CA 92101",
  phone: "(619)269-4626",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13426.237964453836!2d-117.1693186!3d32.7243313!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xe21b3dd670f24e93!2sUnderbelly!5e0!3m2!1sen!2sus!4v1497467117028' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Hokkaido Ramen Santouka",
  operating_hours: {
    "sunday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    },
    "monday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    },
    "tuesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    },
    "wednesday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    },
    "thursday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    },
    "friday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    },
    "saturday": {
      lunch: ["11:00","0"],
      dinner: ["0", "20:30"]
    }
  },
  address: "4240 Kearny Mesa Rd Mitsuwa Market Pl San Diego CA 92111",
  phone: "(858)974-1101",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13411.9879035453!2d-117.1502145!3d32.8188451!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x674d0d25be32cf81!2sSantouka+Ramen+(Mitsuwa+Market)!5e0!3m2!1sen!2sus!4v1497467163077' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Yakitori Yakyudori & Ramen",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:30"]
    },
    "monday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:30"]
    },
    "tuesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:30"]
    },
    "wednesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:30"]
    },
    "thursday": {
      lunch: ["11:30","0"],
      dinner: ["0", "23:30"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "02:45"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "02:45"]
    }
  },
  address: "4898 Convoy St San Diego CA 92111",
  phone: "(858)268-2888",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13410.222053426247!2d-117.1537929!3d32.8305403!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xd24bfc7d71d4012b!2sYakyudori+(ramen+and+yakitori)!5e0!3m2!1sen!2sus!4v1497467226126' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Below restaurant is breaking the app!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# restaurants << Restaurant.create(
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
restaurants << Restaurant.create(
  name: "BeShock Ramen & Sake Bar",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "21:30"]
    },
    "monday": {
      lunch: ["11:30","0"],
      dinner: ["0", "21:30"]
    },
    "tuesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "21:30"]
    },
    "wednesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "21:30"]
    },
    "thursday": {
      lunch: ["11:30","0"],
      dinner: ["0", "21:30"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:30"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:30"]
    }
  },
  address: "1288 Market St San Diego CA 92101",
  phone: "(619)501-9612",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13428.13719400144!2d-117.1530632!3d32.7117163!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x2b1a4a8e92097eb2!2sBeShock+Ramen+%26+Sake+Bar!5e0!3m2!1sen!2sus!4v1497467269874' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Below restaurant is breaking the app!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# restaurants << Restaurant.create(
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
restaurants << Restaurant.create(
  name: "Tajima Ramen East Village",
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
      dinner: ["0", "22:30"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "03:00"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "03:00"]
    }
  },
  address: "901 E St San Diego CA 92101",
  phone: "(619)431-5820",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13427.71676986495!2d-117.1563564!3d32.7145092!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x51835f6593ab15d1!2sTajima+Ramen+East+Village!5e0!3m2!1sen!2sus!4v1497467330988' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Tokyo Ramen",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:00", "22:00"]
    },
    "monday": {
      lunch: ["0","0"],
      dinner: ["0", "0"]
    },
    "tuesday": {
      lunch: ["0","0"],
      dinner: ["0", "0"]
    },
    "wednesday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:00", "22:00"]
    },
    "thursday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:00", "22:00"]
    },
    "friday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:00", "22:30"]
    },
    "saturday": {
      lunch: ["11:30","15:00"],
      dinner: ["17:00", "22:30"]
    }
  },
  address: "501 University Ave San Diego CA 92103",
  phone: "(619)738-8538",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13422.660452659176!2d-117.1602215!3d32.748082!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x7835847511726b7a!2sTokyo+Ramen!5e0!3m2!1sen!2sus!4v1497467383360' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Ramen Yamadaya(Broadway)",
  operating_hours: {
    "sunday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "monday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "tuesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "wednesday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "thursday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "friday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    },
    "saturday": {
      lunch: ["11:30","0"],
      dinner: ["0", "22:00"]
    }
  },
  address: "531 Broadway San Diego CA 92101",
  phone: "(619)241-2251",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13427.562615888439!2d-117.1594738!3d32.7155332!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xe53a543543907f61!2sRamen+Yamadaya!5e0!3m2!1sen!2sus!4v1497467420387' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )
restaurants << Restaurant.create(
  name: "Donburi Kitchen",
  operating_hours: {
    "sunday": {
      lunch: ["0","0"],
      dinner: ["0", "0"]
    },
    "monday": {
      lunch: ["11:30","14:30"],
      dinner: ["17:00", "21:00"]
    },
    "tuesday": {
      lunch: ["11:30","14:30"],
      dinner: ["17:00", "21:00"]
    },
    "wednesday": {
      lunch: ["11:30","14:30"],
      dinner: ["17:00", "21:00"]
    },
    "thursday": {
      lunch: ["11:30","14:30"],
      dinner: ["17:00", "21:00"]
    },
    "friday": {
      lunch: ["11:30","14:30"],
      dinner: ["17:00", "21:00"]
    },
    "saturday": {
      lunch: ["11:30","14:30"],
      dinner: ["17:00", "21:00"]
    }
  },
  address: "6030 Santo Rd San Diego CA 92124",
  phone: "(858)737-4224",
  maplink: "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13408.72127896363!2d-117.09798!3d32.840477!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xeee57b321f8ed02!2sDonburi+Kitchen!5e0!3m2!1sen!2sus!4v1497467469440' width='400' height='300' frameborder='0' style='border:0' allowfullscreen></iframe>"
  )

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Below restaurant is breaking the app!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# restaurants << Restaurant.create(
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

k = 1
Restaurant.all.each do |restaurant|
  k += 1
  restaurant.update(number_of_seats: 60)
  restaurant.update(image_path: "/#{k}.jpg")
end


restaurants.each do |restaurant|

  Admin.create(email: restaurant.name.gsub(" ","_").gsub(")","").gsub("(","_").concat("@email.com").downcase, password: 'password', restaurant_id: restaurant.id)
  i = 0
  puts restaurant
  puts restaurant.id
  while i < 180
    name = Faker::Name.first_name
    party_size = [1,2,3,4].sample

    num_minutes_between_waittime_creation_events = 6
    num_minutes_between_party_seating_events = 8
    num_parties_before = Waittime.where(seated: false, restaurant_id: restaurant.id).length || 0

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
      w = Waittime.create(seated:false, party_size: party_size, customer: name, phone: '1112223333', restaurant_id: restaurant.id, number_of_parties_before: num_parties_before)
      w.update(created_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
    end

    # If it's the correct minute, seat the first party
    if i % num_minutes_between_party_seating_events == 0 && i > 0
      party_to_seat = Waittime.where(seated:false, restaurant_id: restaurant.id).order(:created_at).first
      puts restaurant.id
      puts Waittime.where(restaurant_id: restaurant.id)
      party_to_seat.update(seated: true, table_ready: true)
      party_to_seat.update(updated_at: DateTime.new(2000,1,1,hour,minute,00,"-08:00"))
      seated_time = (party_to_seat.updated_at.to_i * 0.0166666666667).to_i - (party_to_seat.created_at.to_i * 0.0166666666667).to_i
      puts seated_time
      party_to_seat.update(seated_time: seated_time)
    end

    if i > 178

    end
    i += 1
  end

end
