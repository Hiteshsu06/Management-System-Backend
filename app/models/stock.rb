class Stock < ApplicationRecord
    has_one_attached :stock_short_term_chart
    has_one_attached :stock_long_term_chart

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
end
