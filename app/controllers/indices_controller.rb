class IndicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @indices = Index.where(user_id: current_user.id)
    if @indices
      indices_data = @indices.map do |index_data|
        IndexSerializer.new(index_data).serializable_hash[:data][:attributes]
      end
      render json: indices_data
    else
      render json: { errors: @indices.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    index_data = Index.new(index_params.merge(user_id: current_user.id))
    if index_data.save
      render json: index_data, status: :created
    else
      render json: { errors: index_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @index_data = Index.find(params[:id])
    if @index_data
      render json: @index_data
    else
      render json: { errors: @index_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    index_data = Index.find(params[:id])
    if index_data.update(index_params)
      render json: index_data
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

  private

  def index_params
    params.permit(:name, :price, :country_id, :category_id, :index_short_term_chart, :index_long_term_chart)
  end
end
