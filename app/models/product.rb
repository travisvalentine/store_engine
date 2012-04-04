class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price
  has_many :orders
  
  has_many :product_categories
  has_many :categories, :through => :product_categories

end