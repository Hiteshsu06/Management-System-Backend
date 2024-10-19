class Index < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
    validates :price, presence: true, numericality: { only_integer: true }
    validates :country_id, presence: true, numericality: { only_integer: true }
    validates :category_id, presence: true, numericality: { only_integer: true }
    validate :index_short_term_validation
    validate :index_long_term_validation

    has_one_attached :index_short_term_chart
    has_one_attached :index_long_term_chart

    def index_short_term_validation
        if index_short_term_chart.attached?
          if index_short_term_chart.byte_size > 20.megabytes
            errors.add(:index_short_term_chart, "should be less than 20 MB")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(index_short_term_chart.content_type)
            errors.add(:index_short_term_chart, "must be a JPEG or PNG")
          end
        else
          errors.add(:index_short_term_chart, "must be attached")
        end
    end

    def index_long_term_validation
        if index_long_term_chart.attached?
          if index_long_term_chart.byte_size > 20.megabytes
            errors.add(:index_long_term_chart, "should be less than 20 MB")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(index_long_term_chart.content_type)
            errors.add(:index_long_term_chart, "must be a JPEG or PNG")
          end
        else
          errors.add(:index_long_term_chart, "must be attached")
        end
    end

    def index_short_term_chart_url
        Rails.application.routes.url_helpers.url_for(index_short_term_chart) if index_short_term_chart.attached?
    end

    def index_long_term_chart_url
        Rails.application.routes.url_helpers.url_for(index_long_term_chart) if index_long_term_chart.attached?
    end

    def self.as_csv
        headings = ['ID', 'Name', 'Price', 'Short Term Chart URL', 'Long Term Chart URL']
        attributes = %w{id name price index_short_term_chart_url index_long_term_chart_url} #customize columns here
        CSV.generate(headers: true) do |csv|
            csv << headings

            all.each do |stock|
                csv << attributes.map{ |attr| stock.send(attr) }
            end
        end
    end
end
