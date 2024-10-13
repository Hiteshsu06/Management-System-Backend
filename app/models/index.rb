class Index < ApplicationRecord
    has_one_attached :index_short_term_chart
    has_one_attached :index_long_term_chart

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
