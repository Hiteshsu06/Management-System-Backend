class StockSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :price, :user_id, :created_at, :updated_at, :stock_short_term_chart_url, :stock_long_term_chart_url
end