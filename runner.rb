require 'date'

@t = DateTime.now()
@collection = [{created_at: DateTime.new(@t.year,@t.month,@t.day,15,00,0, "-08:00"), updated_at: DateTime.new(@t.year,@t.month,@t.day,15,30,0, "-08:00")}, {created_at: DateTime.new(@t.year,@t.month,@t.day,15,00,0, "-08:00"), updated_at: DateTime.new(@t.year,@t.month,@t.day,16,00,0, "-08:00")}]

@num_seats = 60

module Waitcalc

@t = DateTime.now()
# @t = DateTime.new(2017,6,9,14,00,0, "-08:00")
@rush_hour_lunch_start = DateTime.new(@t.year,@t.month,@t.day,12,00,0, "-08:00")
@rush_hour_lunch_end = DateTime.new(@t.year,@t.month,@t.day,14,30,0, "-08:00")
@rush_hour_dinner_start = DateTime.new(@t.year,@t.month,@t.day,18,00,0, "-08:00")
@rush_hour_dinner_end = DateTime.new(@t.year,@t.month,@t.day,21,00,0, "-08:00")

# puts @t.strftime('%A')
# @collection = Waittime.where("EXTRACT(dow FROM (created_at)) = ?", DateTime.now.wday).map{|date| date.created_at.hour == @t.hour}
# @unseated = Waittime.where(seated: false)

def self.estimated_waitime(row)
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

end

def self.collection_avg(collection)
  total_times = collection.map{|party| estimated_waitime(party)}
  customer_time = total_times.reduce(:+) / collection.length
end

def self.find_waitime_app(collection=nil, seats)
  algorithm_time = base_alg(seats)
  if collection
   customer_time = collection_avg(collection)
   estimated_time = (algorithm_time + customer_time)/2
   puts estimated_time
  else
   algorithm_time
   puts algorithm_time
  end
end

def self.find_waitime_customer(unseated_list, list_position)
  list_length = unseated_list.length
  base_time = base_alg
  if rush_hour?
    times = rand(0..10)
    p full_time = base_time + times
  else
    times = rand(10..15)
    p full_time = base_time + times
  end
  i = 0
  until i == unseated_list[list_position].party_size
    full_time = full_time + 10
    i += 1
  end
end

end
# puts estimated_waitime(@collection[0])
Waitcalc.find_waitime_app(@collection, @num_seats)
