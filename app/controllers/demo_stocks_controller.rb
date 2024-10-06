class DemoStocksController < ApplicationController
  before_action :authenticate_user!

  def index
    user_companies = DemoCompany.where(user_id: current_user.id)
    @stocks = Stock.where(demo_company_id: user_companies.pluck(:id))
    if @stocks
      render json: @stocks
    else
      render json: { errors: @stocks.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    stock = Stock.new(stock_params)
    if stock.save
      render json: stock, status: :created
    else
      render json: { errors: stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @stock = Stock.find(params[:id])
    @company_details = DemoCompany.find(@stock.company_id)
    if @stock
      render json: @stock.merge(company: @company_details.as_json)
    else
      render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    stock = Stock.find(params[:id])
    if stock.update(stock_params)
      render json: stock
    else
      render json: { errors: stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    stock = Stock.find_by(id: params[:id])
    if stock.destroy
      head :ok
    else
      render json: { errors: stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.permit(:category, :brand_name, :model_number, :stock_name, :product_qty, :buy_price, :sell_price, :gst_number, :company_id)
  end
end
