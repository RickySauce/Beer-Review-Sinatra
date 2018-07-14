class CreateUserBeers < ActiveRecord::Migration
  def change
    create_table :user_beers do |u|
      u.integer :user_id 
      u.integer :beer_id 
    end
  end
end
