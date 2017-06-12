class Waittime < ActiveRecord::Base
  belongs_to :restaurant

  def estimated_waittime
    Waitcalc.find_waittime(self.number_of_parties_before)
  end
end
