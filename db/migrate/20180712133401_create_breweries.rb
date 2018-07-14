class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |b|
      b.string :name
      b.float :rating
    end
  end
end
