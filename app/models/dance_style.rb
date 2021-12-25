class DanceStyle < ApplicationRecord
    belongs_to :event
    belongs_to :instructor 
end
