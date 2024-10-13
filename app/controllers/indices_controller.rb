class IndicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @indices_domestic_data = Index.where(user_id: current_user.id, category_id: 0)
    @indices_international_data = Index.where(user_id: current_user.id, category_id: 1)
    if @indices_domestic_data && @indices_international_data
      indices_domestic_data = @indices_domestic_data.map do |index_data|
        IndexSerializer.new(index_data).serializable_hash[:data][:attributes]
      end
      indices_international_data = @indices_international_data.map do |index_data|
        IndexSerializer.new(index_data).serializable_hash[:data][:attributes]
      end
      render json: 
        { data: { 
            domestic_data: indices_domestic_data, 
            international_data: indices_international_data
        }}
    else
      render json: { errors: @indices.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def get_all_countries_list
    @countries = ListOfCountries.countries
    if @countries
      @countries_data = @countries.map do |country|
        {
          name: country.name.common,   # Access the common name using the name method
          region: country.region       # Access the region directly
        }
      end
      render json: @countries_data
    else
      render json: { errors: "List of coutries currently unavailable" }, status: :unprocessable_entity
    end
  end

  def create
    index_data = Index.new(index_params.merge(user_id: current_user.id))
    if index_data.save
      render json: { data: index_data, message: 'Index has been successfully created'}, status: :created
    else
      render json: { errors: index_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @index_data = Index.find(params[:id])
    if @index_data
      render json: IndexSerializer.new(@index_data).serializable_hash[:data][:attributes]
    else
      render json: { errors: @index_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    index_data = Index.find(params[:id])
    if index_data.update(index_params)
      render json: { data: index_data, message: 'Index has been successfully updated'}
    else
      render json: { errors: index_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    index_data = Index.find_by(id: params[:id])
    if index_data.destroy
      head :ok
    else
      render json: { errors: index_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def export_indices_report
    @indices = Index.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.csv { send_data @indices.as_csv, filename: "indices-#{Date.today}.csv" }
    end
  end

  private

  def index_params
    params.permit(:name, :price, :country_id, :category_id, :index_short_term_chart, :index_long_term_chart)
  end
end
