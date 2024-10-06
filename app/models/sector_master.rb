class SectorMaster < ApplicationRecord
    has_one_attached :sector_short_term_chart
    has_one_attached :sector_long_term_chart

    def sector_short_term_chart_url
        Rails.application.routes.url_helpers.url_for(sector_short_term_chart) if sector_short_term_chart.attached?
    end

    def sector_long_term_chart_url
        Rails.application.routes.url_helpers.url_for(sector_long_term_chart) if sector_long_term_chart.attached?
    end
end
