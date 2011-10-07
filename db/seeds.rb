# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Genre.delete_all
["Spot", "Eat", "Stay", "Shopping", "Activity"].each do |name|
  Genre.create(:name => name)
end

Category.delete_all
SubCategory.delete_all

["Place name", "Train Station", "Subway", "Airport"].each do |name|
  Genre.find_by_name("Spot").categories.create(:name => name)
end

["African", "American", "Japanese", "BBQ", "Cafe"].each do |name|
  Genre.find_by_name("Eat").categories.create(:name => name)
end

["Hotel", "Mortel", "Japanese Style"].each do |name|
  Genre.find_by_name("Stay").categories.create(:name => name)
end

["Mall", "Gift shop", "Miscellaneous Shop", "Music Store"].each do |name|
  Genre.find_by_name("Shopping").categories.create(:name => name)
end

["Area name", "Country"].each do |name|
  Category.find_by_name("Place name").sub_categories.create(:name => name)
end
