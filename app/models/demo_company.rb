class DemoCompany < ApplicationRecord
    has_many :demo_stock
    belongs_to :user
end
