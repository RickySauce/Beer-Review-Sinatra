class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |b|
      b.string :name
    end
  end
end
