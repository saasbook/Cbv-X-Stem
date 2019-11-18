# This file should contain all the record creation needed to seed the database wi   th its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [{:first_name => "Peter", :last_name => "Pei", :email => "pp2@gmail.com",  :whatsapp=> "6198089569", :password => "password", :password_confirmation => "password"},
         {:first_name => "Tom", :last_name => "Brady", :email => "tomb2@gmail.com",  :whatsapp=> "6198089569", :password => "password", :password_confirmation => "password"},
         {:first_name => "Steven", :last_name => "Jobs", :email => "stevenj2@gmail.com",  :whatsapp=> "6198089569", :password => "password", :password_confirmation => "password"},
         {:first_name => "Bill", :last_name => "Gates", :email => "bliig2@gmail.com",  :whatsapp=> "6198089569", :password => "password", :password_confirmation => "password"},
]

users.each do |current_user|
  new_user = User.new(first_name: current_user[:first_name], last_name: current_user[:last_name], email: current_user[:email], password: current_user[:password], password_confirmation: current_user[:password_confirmation])
  # new_user.skip_confirmation!
  new_user.save!
  new_user_holder = UserHolder.create!(first_name: new_user.first_name,
                                  last_name: new_user.last_name,
                                  email: new_user.email,
                                  user_id: new_user.id)
  newprofile = Profile.create(first_name: new_user.first_name,
                              last_name: new_user.last_name,
                              email: new_user.email,
                              user_holder_id: new_user_holder.id)
end
