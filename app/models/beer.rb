class Beer < ActiveRecord::Base

  has_many :reviews
  has_many :user_beers
  belongs_to :brewery

  def rating
    self.reviews.each do |review|
      @rating = 0 if @rating.nil?
      @rating += review.rating
    end
    @rating /= self.reviews.count
    @rating.round(2)
  end
end
