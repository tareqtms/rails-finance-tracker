class UserStocksController < ApplicationController
  before_action :set_user_stock, only: [:show, :edit, :update, :destroy]

  # GET /user_stocks
  # GET /user_stocks.json
  def index
    @user_stocks = UserStock.all
  end

  # GET /user_stocks/1
  # GET /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks
  # POST /user_stocks.json
  def create
    if params[:stock_id].present?
      @user_stock = UserStock.new(user:current_user, stock_id: params[:stock_id])
    else 
      @stock = Stock.find_by_ticker(params[:stock_ticker])
      if @stock
        @user_stock = UserStock.new(user:current_user, stock: @stock)
      else 
        @stock = Stock.new_from_lookup(params[:stock_ticker])
        if @stock && @stock.save
          @user_stock = UserStock.new(user:current_user, stock: @stock)
        else 
          flash[:error] = "Stock ticker not found!"
        end
      end

    end

    respond_to do |format|
      if @user_stock.save
        format.html { redirect_to my_portfolio_path, notice: "Stock #{@user_stock.stock.ticker} was successfully added" }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stocks/1
  # DELETE /user_stocks/1.json
  def destroy
    @user_stock.destroy
    respond_to do |format|
      format.html { redirect_to my_portfolio_path, notice: 'Stock was removed successfully from the portfolio.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = UserStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id)
    end
end