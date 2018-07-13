require 'nokogiri'
require 'open-uri'

class Scraper

  def self.parse
    self.new.create_beers
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
  end

  def create_reviews
    Beer.all.each do |beer|
      doc = Nokogiri::HTML(open("https://www.beeradvocate.com#{beer.url}"))
      doc.css("div#rating_fullview_container").each do |review|
        text = review.children[1].children.reject {|item| item if item.name == "span"}
        text.collect! {|item| item.text}
        text.delete_at(0) && text.delete_at(-1)
        binding.pry
        review = {

        }
      end
    end
  end

end

#ratings = review.delete(css("span.muted"))
