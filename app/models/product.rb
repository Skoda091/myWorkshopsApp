class Product < ActiveRecord::Base
    validates :title,presence:true
  	validates :description,presence:true
  	validates :price,presence:true
   	validates :price, :format => { :with => /\A^\d+\.*\d{0,2}$\z/ }
  	
  	belongs_to :category
  	belongs_to :user
  	has_many :reviews

  	def average_rating
   		sum = 0.0
  		reviews.each { |a| sum+=a.rating }
  		return sum/reviews.length
  	end

end
