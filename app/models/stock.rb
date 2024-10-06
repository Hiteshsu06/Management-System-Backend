class Stock < ApplicationRecord
    has_one_attached :stock_short_term_chart
    has_one_attached :stock_long_term_chart

    def stock_short_term_chart_url
        Rails.application.routes.url_helpers.url_for(stock_short_term_chart) if stock_short_term_chart.attached?
    end

    def stock_long_term_chart_url
        Rails.application.routes.url_helpers.url_for(stock_long_term_chart) if stock_long_term_chart.attached?
    end
end
