class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :beer

  def rating
    @rating = (self.look + self.feel + self.taste + self.smell) / 4.0
    @rating.round(2)
  end

end
