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
          :abv => beer_info.css("div#extendedInfo").text.split("/ ").last.gsub("% ABV","").to_f
        }
        brewery = {
          :name => beer_info.css("td a")[1].text
        }
        brewery = Brewery.find_or_create_by(brewery)
        beer = Beer.find_or_create_by(beer)
        beer.brewery = brewery
      end
  end

end
