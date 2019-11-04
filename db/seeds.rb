# This file should contain all the record creation needed to seed the database wi   th its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users = [{:first_name => "Peter", :last_name => "Pei", :email => "pp@gmail.com", :encrypted_password => "123", :reset_password_token => "123"}]
profiles= [{:first_name => 'Tom', :last_name => "Brady", :email => "1@gmai.com", :user_holder_id => 1},
           {:first_name => 'Tom', :last_name => "James", :email => "2@gmai.com", :user_holder_id => 2},
           {:first_name => 'Bill', :last_name => "Gates", :email => "3@gmai.com", :user_holder_id => 3},
           {:first_name => 'Bill', :last_name => "Jobs", :email => "4@gmai.com", :user_holder_id => 4},
           {:first_name => 'Steven', :last_name => "Jobs", :email => "5@gmai.com", :user_holder_id => 5},
  	 ]
# users.each do |user|
#     User.create!(user)
# end

profiles.each do |profile|
  Profile.create!(profile)
end