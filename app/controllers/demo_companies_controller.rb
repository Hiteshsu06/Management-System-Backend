class DemoCompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = DemoCompany.where(user_id: current_user.id)
    if @companies
      UserMailer.welcome_email('Hitesh').deliver_now
      render json: @companies
    else
      render json: { errors: @companies.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    company = DemoCompany.new(company_params.merge(user_id: current_user.id))
    if company.save
      render json: { data: company, message: 'Company has been successfully created'}, status: :created
    else
      render json: { errors: company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @company = DemoCompany.find(params[:id])
    if @company
      render json: @company
    else
      render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    company = DemoCompany.find(params[:id])
    if company.update(company_params)
      render json: { data: company, message: 'Company has been successfully updated'}
    else
      render json: { errors: company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    company = DemoCompany.find_by(id: params[:id])
    if company.destroy
      head :ok
    else
      render json: { errors: company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.permit(:name, :address, :contact_number, :gst_number)
  end
end
