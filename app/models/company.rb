class Company < ApplicationRecord
    has_many :stocks
    belongs_to :user
end
