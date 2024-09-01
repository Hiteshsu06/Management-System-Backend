class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    user_companies = Company.where(user_id: current_user.id)
    @stocks = Stock.where(company_id: user_companies.pluck(:id))
    render json: @stocks
  end

  def create
    stock = Stock.create(stock_params)
    render json: stock
  end

  def show
    @stock = Stock.find(params[:id])
    @company_details = Company.find(@stock.company_id)
    render json: @stock.merge(company: @company_details.as_json)
  end

  def update
    stock = Stock.find(params[:id])
    stock.update(stock_params)
    render json: stock
  end

  def destroy
    Stock.destroy(params[:id])
    head :ok
  end

  private

  def stock_params
    params.permit(:category, :brand_name, :model_number, :stock_name, :product_qty, :buy_price, :sell_price, :gst_number, :company_id)
  end
end
