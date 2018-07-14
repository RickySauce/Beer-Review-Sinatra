class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |r|
      r.string :content
      r.integer :beer_id
      r.integer :user_id
      r.float :taste
      r.float :look
      r.float :smell
      r.float :feel
      r.float :rating
    end
  end
end
