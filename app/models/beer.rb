class Beer < ActiveRecord::Base

  has_many :reviews
  belongs_to :brewery

  def rating
    @rating = self.reviews.each {|}
  end
end
