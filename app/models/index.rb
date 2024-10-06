class Index < ApplicationRecord
    has_one_attached :index_short_term_chart
    has_one_attached :index_long_term_chart

    def index_short_term_chart_url
        Rails.application.routes.url_helpers.url_for(index_short_term_chart) if index_short_term_chart.attached?
    end

    def index_long_term_chart_url
        Rails.application.routes.url_helpers.url_for(index_long_term_chart) if index_long_term_chart.attached?
    end
end
