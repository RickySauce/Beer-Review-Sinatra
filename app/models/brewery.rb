class Brewery < ActiveRecord::Base

  has_many :beers

  def rating
    @rating = self.beers.each {|beer|@rating += beer.rating}
    @rating /= self.beers.count
    @rating.round(2)
  end

end
