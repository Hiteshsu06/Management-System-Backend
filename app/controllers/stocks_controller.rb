class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = Stock.where(user_id: current_user.id)
    if @stocks
      stocks_data = @stocks.map do |stock|
        StockSerializer.new(stock).serializable_hash[:data][:attributes]
      end
      
      render json: stocks_data
    else
      render json: { errors: @stocks.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    stock = Stock.new(stock_params.merge(user_id: current_user.id))
    if stock.save
      render json: { data: stock, message: 'Stock has been successfully created'}, status: :created
    else
      render json: { errors: stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @stock = Stock.find(params[:id])
    if @stock
      render json: StockSerializer.new(@stock).serializable_hash[:data][:attributes]
    else
      render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    stock = Stock.find(params[:id])
    if stock.update(stock_params)
      render json: { data: stock, message: 'Stock has been successfully updated'}
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

  def export_stocks_report
    @stocks = Stock.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.csv { send_data @stocks.as_csv, filename: "stocks-#{Date.today}.csv" }
    end
  end

  private

  def stock_params
    params.permit(:name, :price, :stock_short_term_chart, :stock_long_term_chart)
  end
end
