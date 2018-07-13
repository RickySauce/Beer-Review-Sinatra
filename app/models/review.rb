class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :beer

  def rating
    @rating = (@look + @feel + @taste + @smell) / 4
  end

end
