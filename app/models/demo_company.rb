class DemoCompany < ApplicationRecord
    has_many :demo_stock, dependent: :destroy
    belongs_to :user
end
