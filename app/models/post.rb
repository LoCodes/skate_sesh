class Post < ActiveRecord::Base 
    belongs_to :skater
    # delegate :username, to: :skater # to access username with chain method. 

end 