class DemoCompany < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
    validates :address, presence: true, length: { maximum: 100 }
    validates :contact_number, presence: true, numericality: { only_integer: true }
    validates :gst_number, presence: true
    validates :gst_number, uniqueness: { scope: :user_id, message: "has already been taken by you" }
    has_many :demo_stocks, dependent: :destroy
    belongs_to :user
end
