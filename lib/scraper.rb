require 'nokogiri'
require 'open-uri'

class Scraper

  def self.parse
    self.new.create_beers
  end

  def create_users
    user_list = {
      "big-guy3000" => {
        :email => "dudeGuy@DudeGuy.com",
        :password => "suh-dude"
      },
      "Guy-Bro-uhsuh" => {
        :email => "uhsuh@suh.com",
        :password => "suhhhhhhhh"
      },
      "Yung-Saucington" => {
        :email => "sauceboss@sauce.com",
        :password => "keepitahunnid'"
      }
    }

    user_list.each do |username, user_hash|
      user = User.find_or_create_by(username: username)
      user.password = user_hash[:password]
      user.email = user_hash[:email]
      user.save
    end
    user_1 = User.all[0]
    user_2 = User.all[1]
    user_3 = User.all[2]
    user_1.review_ids = [1, 2, 3]
    user_1.beers = user_1.reviews.collect {|review| review.beer}
    user_2.review_ids = [4, 5, 6]
    user_2.beers = user_2.reviews.collect {|review| review.beer}
    user_3.review_ids = [7, 8, 9]
    user_3.beers = user_3.reviews.collect {|review| review.beer}
  end

  def create_beers
    doc = Nokogiri::HTML(open("https://www.beeradvocate.com/lists/top/"))
    doc.css("table tr").drop(2).each do |beer_info|
        beer = {
          :name => beer_info.css("td a b").text,
          :url => beer_info.css("td a").attribute('href').value,
          :abv => beer_info.css("div#extendedInfo").text.split("/ ").last.gsub("% ABV","").to_f
        }
        brewery = {
          :name => beer_info.css("td a")[1].text
        }
        brewery = Brewery.find_or_create_by(brewery)
        beer = Beer.find_or_create_by(beer)
        beer.brewery = brewery
        brewery.beers << beer
      end
      self.create_reviews
      Brewery.all.each do |brewery|
        brewery.rating = brewery.rating
        brewery.save
      end
      self.create_users
  end

  def create_reviews
    Beer.all.each do |beer|
      doc = Nokogiri::HTML(open("https://www.beeradvocate.com#{beer.url}"))
      doc.css("div#rating_fullview_container").each do |review|
        text = review.children[1].children.reject {|item| item if item.name == "span"}
        text.collect! {|item| item.text}
        text.delete_at(0) && text.delete_at(-1)
        text = text.join.gsub("\n","")
        ratings = review.css("span.muted").text.split(" | ")
        review = {
          :content => text,
          :look => ratings[0].split(": ").last.to_f,
          :smell => ratings[1].split(": ").last.to_f,
          :taste => ratings[2].split(": ").last.to_f,
          :feel => ratings[3].split(": ").last.to_f
        }
        review = Review.find_or_create_by(review)
        review.rating = review.rating
        review.beer = beer
        beer.reviews << review
        review.save
        beer.save
      end
    end
  end

end

#ratings = review.delete(css("span.muted"))

user = User.create(username: "Sam", password: "fred")
