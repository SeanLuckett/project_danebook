# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker/educator'
require 'faker/address'
require 'faker/phone_number'

words_to_live_by = 'Gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato. Dandelion cucumber earthnut pea peanut soko zucchini.'

about_me = 'Turnip greens yarrow ricebean rutabaga endive cauliflower sea lettuce kohlrabi amaranth water spinach avocado daikon napa cabbage asparagus winter purslane kale. Celery potato scallion desert raisin horseradish spinach carrot soko. Lotus root water spinach fennel kombu maize bamboo shoot green bean swiss chard seakale pumpkin onion chickpea gram corn pea. Brussels sprout coriander water chestnut gourd swiss chard wakame kohlrabi beetroot carrot watercress. Corn amaranth salsify bunya nuts nori azuki bean chickweed potato bell pepper artichoke.'

5.times do |i|
  account = Account.new email: "pat#{i}.just@nyc.com",
                        password: "foo#{i}barr",
                        password_confirmation: "foo#{i}barr"

  account.build_user first_name: "Pat#{i}",
                     last_name: "Foo",
                     birthdate: 20.years.ago,
                     college: Faker::Educator.university,
                     hometown: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
                     lives_in: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
                     telephone: Faker::PhoneNumber.phone_number,
                     words_live_by: words_to_live_by,
                     about_me: about_me

  account.save!
  account.user.posts.create([
                              { body: Faker::Hipster.paragraph(4) },
                              { body: Faker::Hipster.paragraph(4) }
                            ])

end