class SectorMastersController < ApplicationController
  before_action :authenticate_user!

  def index
    @sectors = SectorMaster.where(user_id: current_user.id)
    if @sectors
      sectors_data = @sectors.map do |sector|
        SectorMasterSerializer.new(sector).serializable_hash[:data][:attributes]
      end
      
      render json: sectors_data
    else
      render json: { errors: @sectors.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    sector = SectorMaster.new(sector_params.merge(user_id: current_user.id))
    if sector.save
      render json: sector, status: :created
    else
      render json: { errors: sector.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @sector = SectorMaster.find(params[:id])
    if @sector
      render json: @sector
    else
      render json: { errors: @sector.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    sector = SectorMaster.find(params[:id])
    if sector.update(sector_params)
      render json: sector
    else
      render json: { errors: sector.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    sector = SectorMaster.find_by(id: params[:id])
    if sector.destroy
      head :ok
    else
      render json: { errors: sector.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sector_params
    params.permit(:name, :price, :sector_short_term_chart, :sector_long_term_chart)
  end
end
