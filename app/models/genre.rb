class Genre < ActiveRecord::Base
  has_many :pages
  has_many :categories
  has_many :sub_categories
  
  def self.dropdown
    all.collect do |row|
      [row.name, row.id]
    end
  end
end
