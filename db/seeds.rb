#encoding: utf-8 
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
users = [ {:uid => '12345', :last_name => 'Wayne', :first_name => 'Bruce', :location => 'Bat Cave, Gotham City', :gender => 'Male', :image => 'http://tinyurl.com/opnc38n', :status => 'looking',
           :phone_number => '(555)228-6261', :email => 'not_batman@wayneenterprises.com', :description => 'I love bats', :availability => 'not nights', :oauth_token => 'ABCDEF...', :oauth_expires_at => '12-Jun-1981'},
        ]
users.each do |user|
  User.create!(user)
end
=end


mix_list = [
  'Any',
  'Airedale',
  'Akita',
  'Australian shepherd',
  'Basset hound',
  'Beagle',
  'Bichon',
  'Border collie',
  'Boxer',
  'Bulldog (American)',
  'Bulldog (French)',
  'Chihuahua',
  'Collie',
  'Dachshund',
  'Dalmation',
  'Doberman',
  'Greyhound',
  'Hound',
  'Husky',
  'Jack Russell',
  'Labrador',
  'Malamute',
  'Mastiff',
  'Mutt',
  'Other',
  'Pit bull',
  'Pomeranian',
  'Poodle',
  'Retreiver',
  'Ridgeback',
  'Rottweiler',
  'Saint Bernard',
  'Samoyed',
  'Schnauzer',
  'Setter',
  'Shar Pei',
  'Sheepdog',
  'Shepherd',
  'Shih Tzu',
  'Spaniel',
  'Staffordshire Terrier',
  'Terrier (other)',
  'Weimaraner',
  'Whippet'

]

mix_delete_list = [
"Australian Stumpy Tail Cattle Dog[10]",
"Welsh Corgi, Cardigan",
  "Welsh Corgi, Pembroke",
    "Münsterländer, Large",
  "Münsterländer, Small",
    "Bleu de Gascogne, Grand",
  "Bleu de Gascogne, Petit",
    "Basset Griffon Vendéen, Grand",
  "Basset Griffon Vendéen, Petit"
]

mix_list.each do |name|
  # Mix.find_or_create_by_value(name)
  @mix = Mix.find_by_value(name) || Mix.create(:value => name)
end

mix_delete_list.each do |name|
  m = Mix.find_by_value(name)
  m.destroy if m
end

energy_list = [
  "high",
  "active",
  "good",
  "some",
  "low",
  "zzzzz"
]

energy_list.each do |level|
  # EnergyLevel.find_or_create_by_value(level)
  en = EnergyLevel.find_by_value(level) || EnergyLevel.create(:value => level)
end

personality_list = [
  "anxious",
  "intence",
  "curious",
  "timid",
  "whatever",
  "friendly",
  "fetcher",
  "lover",
  "still a puppy"
]

personality_list.each do |type|
  # Personality.find_or_create_by_value(type)
  per = Personality.find_by_value(type) || Personality.create(:value => type)
end


likes_list = [
  "dogs (all)",
  "dogs (some or most)",
  "cats",
  "men",
  "women",
  "children"
]

likes_list.each do |item|
  # Like.find_or_create_by_value(item)
  lk = Like.find_by_value(item) || Like.create(:value => item)
end

sizes_list = [
  "small (0-15)",
  "medium (16-40)",
  "large (41-100)",
  "xl (101+)"
]

sizes_list.each do |size|
  # Size.find_or_create_by_value(size)
  sz = Size.find_by_value(size) || Size.create(:value => size)
end

#dogs_list = [{:name => "Fluffy", :gender => "Female", :size_id => 1}, {:name => "Fido", :gender => "Male", :size_id => 3}, {:name => "Batman", :gender => "Female", :size_id => 2}]
#
#dogs_list.each do |dog|
#  dog = Dog.create(:name => dog[:name], :gender => dog[:gender])
#  dog.size_id = dog[:size_id]
#  dog.save 
#end
