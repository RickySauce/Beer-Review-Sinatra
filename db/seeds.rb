users_list = {
  "big-guy3000" => {
    :email => "dudeGuy@DudeGuy.com"
    :password_digest => "suh-dude"
  },
  "Guy-Bro-uhsuh" => {
    :email => "uhsuh@suh.com"
    :password_digest => "suhhhhhhhh"
  }
}

user_list.each do |name, user_hash|
  p = User.new
  p.name = name
  landmark_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end
