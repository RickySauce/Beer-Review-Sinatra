class Beer < ActiveRecord::Base

  has_many :reviews
  belongs_to :brewery

  def rating
    @rating = self.reviews.each {|review| @rating += review.rating}
    @rating /= self.reviews.count
    @rating.round(2)
  end
end
