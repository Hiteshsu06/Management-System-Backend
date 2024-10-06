class IndexSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :price, :country_id, :category_id, :created_at, :updated_at, :index_short_term_chart_url, :index_long_term_chart_url
end
