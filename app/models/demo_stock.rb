class DemoStock < ApplicationRecord
    validates :brand_name, presence: true, length: { maximum: 20 }
    validates :category, presence: true, length: { maximum: 20 }
    validates :model_number, presence: true, length: { maximum: 20 }
    validates :stock_name, presence: true, length: { maximum: 20 }
    validates :product_qty, presence: true, numericality: { only_integer: true }
    validates :buy_price, presence: true, numericality: { only_integer: true }
    validates :sell_price, presence: true, numericality: { only_integer: true }
    validates :gst_number, presence: true
    validates :gst_number, uniqueness: { message: "has already been taken by you" }
    belongs_to :demo_company
end