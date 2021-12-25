class Instructor < ApplicationRecord
    has_many :bookings
    has_many :events, through: :bookings
    has_many :dance_styles 
end
