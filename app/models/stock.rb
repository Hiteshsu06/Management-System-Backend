class Stock < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
    validates :price, presence: true, numericality: { only_integer: true }
    validate :stock_short_term_validation
    validate :stock_long_term_validation

    has_one_attached :stock_short_term_chart
    has_one_attached :stock_long_term_chart

    def stock_short_term_validation
        if stock_short_term_chart.attached?
          if stock_short_term_chart.byte_size > 20.megabytes
            errors.add(:stock_short_term_chart, "should be less than 20 MB")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(stock_short_term_chart.content_type)
            errors.add(:stock_short_term_chart, "must be a JPEG or PNG")
          end
        else
          errors.add(:stock_short_term_chart, "must be attached")
        end
    end

    def stock_long_term_validation
        if stock_long_term_chart.attached?
          if stock_long_term_chart.byte_size > 20.megabytes
            errors.add(:stock_long_term_chart, "should be less than 20 MB")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(stock_long_term_chart.content_type)
            errors.add(:stock_long_term_chart, "must be a JPEG or PNG")
          end
        else
          errors.add(:stock_long_term_chart, "must be attached")
        end
    end

    def sector
        SectorMaster.find(sector_masters_id)
    end

    def stock_short_term_chart_url
        Rails.application.routes.url_helpers.url_for(stock_short_term_chart) if stock_short_term_chart.attached?
    end

    def stock_long_term_chart_url
        Rails.application.routes.url_helpers.url_for(stock_long_term_chart) if stock_long_term_chart.attached?
    end

    def self.as_csv
        headings = ['ID', 'Name', 'Price', 'Short Term Chart URL', 'Long Term Chart URL']
        attributes = %w{id name price stock_short_term_chart_url stock_long_term_chart_url} #customize columns here
        CSV.generate(headers: true) do |csv|
            csv << headings

            all.each do |stock|
                csv << attributes.map{ |attr| stock.send(attr) }
            end
        end
    end

    belongs_to :sector_master, optional: true
end
