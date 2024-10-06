class SectorMasterSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :created_at, :updated_at, :sector_short_term_chart_url, :sector_long_term_chart_url
end
