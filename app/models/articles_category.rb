class ArticlesCategory < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :categories
 
end
