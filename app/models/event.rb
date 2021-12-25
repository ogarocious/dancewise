class Event < ApplicationRecord
        has_many :bookings
        has_many :instructors, through: :bookings
        has_many :dance_styles
end
