class User < ActiveRecord::Base
  has_secure_password

  has_many :user_beers
  has_many :beers, through: :user_beers
  has_many :reviews
  has_many :breweries, through: :beers

  def breweries
    self.beers.collect do |beer|
      beer.brewery
    end.uniq
  end

end
