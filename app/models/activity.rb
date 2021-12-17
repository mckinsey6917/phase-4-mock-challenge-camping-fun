class Activity < ApplicationRecord
    has_many :signups, dependent: :destroy
                        #we need to delete signups if there is no activity 
                        #handle this in model
    has_many :campers, through: :signups 
end
