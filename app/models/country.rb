class Country < ActiveRecord::Base
  has_many :pages
  belongs_to :area
end
