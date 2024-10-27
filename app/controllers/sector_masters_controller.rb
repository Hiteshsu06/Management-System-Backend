class SectorMastersController < ApplicationController
  before_action :authenticate_user!
  before_action -> { authorize_role(ROLES[:ADMIN], ROLES[:SUPER_ADMIN]) }

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

  def filter
    @sectors = SectorMaster.where(user_id: current_user.id).where("name ILIKE ?", "%#{params[:search]}%")
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
      render json: { data: sector, message: 'Sector has been successfully created'}, status: :created
    else
      render json: { errors: sector.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @sector = SectorMaster.find(params[:id])
    if @sector
      render json: SectorMasterSerializer.new(@sector).serializable_hash[:data][:attributes]
    else
      render json: { errors: @sector.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    sector = SectorMaster.find(params[:id])
    if sector.update(sector_params)
      render json: { data: sector, message: 'Sector has been successfully updated'}
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

  def export_sector_report
    @sectors = SectorMaster.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.csv { send_data @sectors.as_csv, filename: "sectors-#{Date.today}.csv" }
    end
  end

  private

  def sector_params
    params.permit(:name, :price, :sector_short_term_chart, :sector_long_term_chart)
  end
end
