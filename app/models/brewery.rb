class Brewery < ActiveRecord::Base

  has_many :beers

  def rating
    @rating = self.beers.each {|beer|@rating += beer.rating}
    @rating /= self.beers.count
  end

end
