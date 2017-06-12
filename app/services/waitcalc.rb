require 'date'

# @t = DateTime.now()
# @collection = [{created_at: DateTime.new(@t.year,@t.month,@t.day,15,00,0, "-08:00"), updated_at: DateTime.new(@t.year,@t.month,@t.day,15,30,0, "-08:00")}, {created_at: DateTime.new(@t.year,@t.month,@t.day,15,00,0, "-08:00"), updated_at: DateTime.new(@t.year,@t.month,@t.day,16,00,0, "-08:00")}]
# @guest = {party_size: 3, parties_ahead: 3, seated: false, created_at: DateTime.now(), updated_at: DateTime.now()}
# @num_seats = 90

module Waitcalc

@t = DateTime.now()
# @t = DateTime.new(2017,6,11,10,00,0, "-08:00")
@rush_hour_lunch_start = DateTime.new(@t.year,@t.month,@t.day,12,00,0, "-08:00")
@rush_hour_lunch_end = DateTime.new(@t.year,@t.month,@t.day,14,30,0, "-08:00")
@rush_hour_dinner_start = DateTime.new(@t.year,@t.month,@t.day,18,00,0, "-08:00")
@rush_hour_dinner_end = DateTime.new(@t.year,@t.month,@t.day,21,00,0, "-08:00")

# puts @t.strftime('%A')
# @collection = Waittime.where("EXTRACT(dow FROM (created_at)) = ?", DateTime.now.wday).map{|date| date.created_at.hour == @t.hour }
# @collection = Waittime.where("EXTRACT(dow FROM (created_at)) = ?", DateTime.now.wday).map{|date| date.created_at.hour == @t.hour && date.party_size == customer.party_size }
# @unseated = Waittime.where(seated: false)

def self.estimated_waitime(row)
# Should maybe be called actual_waittime? - Paul
  est_time = (row[:updated_at] - row[:created_at]) * 1440
  est_time.to_i

end



def self.rush_hour?
  return true if @t > @rush_hour_lunch_start && @t < @rush_hour_lunch_end || @t > @rush_hour_dinner_start && @t < @rush_hour_dinner_end
end


def self.base_alg(seats)
  arr = []
  leaving = []
  seats.times do
    if rush_hour?
      times = rand(0..30)
    else
      times = rand(30..59)
    end
    rem_time = 60 - times
    full_time = rem_time + 5
    arr << full_time
    if full_time < 26
    leaving << full_time
    end
  end
   average_time = arr.reduce(:+)/seats
   algorithm_time = arr.reduce(:+) - leaving.length * average_time
   algorithm_time = algorithm_time/seats
   data = {alg_time: algorithm_time, avg_time: average_time}

end

# def self.collection_avg(collection)
#   total_times = collection.map{|party| estimated_waitime(party)}
#   customer_time = total_times.reduce(:+) / collection.length
# end



def self.find_waitime_app(collection=nil, seats)
  alg_data = base_alg(seats)
  if collection
   total_times = collection.map{|party| estimated_waitime(party)}
   total_times << alg_data[:alg_time]
   estimated_time = total_times.reduce(:+) / collection.length + 1
   p estimated_time
  else
   algorithm_time
   puts algorithm_time
  end
end


# What increases time?
# Party size increases from 1 -> 2, after that will increase every other increase (3 and 4 are the same), will increase at 5
# Increases for their placement on the list
# Assume we know # of parties ahead

def self.find_list_waitime(collection, seats, guest, prev_guest_time=nil)

  party_size = guest[:party_size]

  if prev_guest_time
   alg_data = base_alg(seats)
   full_time = prev_guest_time
   full_time += alg_data[:avg_time]
  else
   alg_data = base_alg(seats)
   full_time = alg_data[:alg_time]
  end

  if party_size < 2
    full_time += 2
  elsif party_size == 2
    full_time += 4
  else
    i = 0
    until i == party_size
      full_time += 5
      i += 1
     end
  end

  col_time = find_waitime_app(collection, seats)
  guest_time = (col_time + full_time)/2

  end

end



# puts estimated_waitime(@collection[0])

# puts Waitcalc.find_first_waitime(@collection,@num_seats, @guest, 13)
