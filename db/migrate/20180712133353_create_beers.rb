class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |b|
      b.string :name
      b.string :url
      b.float :abv
      b.integer :brewery_id
    end
  end
end
