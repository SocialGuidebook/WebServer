class Category < ActiveRecord::Base
  belongs_to :genre
  has_many :pages
  has_many :sub_categories

  def self.dropdown
    all.collect do |row|
      [row.name, row.id]
    end
  end
end
