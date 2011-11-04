class Genre < ActiveRecord::Base
  has_many :pages
  has_many :categories
  has_many :sub_categories
  
  def self.dropdown
    all.collect do |row|
      [row.name, row.id]
    end
  end
  
  def self.PostCategories(name)
    @categories ||= Genre.all
    @categories.each do |category|
      return category if category.name == name
    end
    nil
  end
end
