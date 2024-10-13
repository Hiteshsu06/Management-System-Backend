class SectorMaster < ApplicationRecord
    has_one_attached :sector_short_term_chart
    has_one_attached :sector_long_term_chart

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
