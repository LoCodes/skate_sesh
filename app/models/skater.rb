class Skater < ActiveRecord::Base 
    has_many :posts


    validates :username, presence: true
    validates :username, uniqueness: true
    has_secure_password 

end 