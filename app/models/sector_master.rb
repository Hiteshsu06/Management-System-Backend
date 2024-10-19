class SectorMaster < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
    validates :price, presence: true, numericality: { only_integer: true }
    validate :sector_short_term_validation
    validate :sector_long_term_validation

    has_one_attached :sector_short_term_chart
    has_one_attached :sector_long_term_chart

    def sector_short_term_validation
        if sector_short_term_chart.attached?
          if sector_short_term_chart.byte_size > 20.megabytes
            errors.add(:sector_short_term_chart, "should be less than 20 MB")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(sector_short_term_chart.content_type)
            errors.add(:sector_short_term_chart, "must be a JPEG or PNG")
          end
        else
          errors.add(:sector_short_term_chart, "must be attached")
        end
    end

    def sector_long_term_validation
        if sector_long_term_chart.attached?
          if sector_long_term_chart.byte_size > 20.megabytes
            errors.add(:sector_long_term_chart, "should be less than 20 MB")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(sector_long_term_chart.content_type)
            errors.add(:sector_long_term_chart, "must be a JPEG or PNG")
          end
        else
          errors.add(:sector_long_term_chart, "must be attached")
        end
    end

    def sector_short_term_chart_url
        Rails.application.routes.url_helpers.url_for(sector_short_term_chart) if sector_short_term_chart.attached?
    end

    def sector_long_term_chart_url
        Rails.application.routes.url_helpers.url_for(sector_long_term_chart) if sector_long_term_chart.attached?
    end

    def self.as_csv
        headings = ['ID', 'Name', 'Price', 'Short Term Chart URL', 'Long Term Chart URL'] 
        attributes = %w{id name price sector_short_term_chart_url sector_long_term_chart_url} #customize columns here
        CSV.generate(headers: true) do |csv|
            csv << headings

            all.each do |sector|
                csv << attributes.map{ |attr| sector.send(attr) }
            end
        end
    end
end
