class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = Company.where(user_id: current_user.id)
    render json: @companies
  end

  def create
    company = Company.create(company_params.merge(user_id: current_user.id))
    render json: company
  end

  def show
    @company = Company.find(params[:id])
    render json: @company
  end

  def update
    company = Company.find(params[:id])
    company.update(company_params)
    render json: company
  end

  def destroy
    Company.destroy(params[:id])
    head :ok
  end

  private

  def company_params
    params.permit(:name, :address, :contact_number, :gst_number)
  end
end
