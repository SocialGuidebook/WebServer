class SubCategory < ActiveRecord::Base
  belongs_to :genre
  belongs_to :category
  
  has_many :pages

  def self.dropdown
    all.collect do |row|
      [row.name, row.id]
    end
  end
end
