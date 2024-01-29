# app/controllers/sales_controller.rb
class SalesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :index, :destroy, :update]
    skip_before_action :require_login, only: [:create, :index, :show, :destroy, :update]
    before_action :set_sale, only: [:show, :edit, :update, :destroy]
  
    def index
      if params[:search_by_release_order].present?
        @sales = Sale.joins(:release).where(releases: { order_ref: params[:search_by_release_order] })
      else
        @sales = Sale.all
      end
  
      render json: @sales
    end
  
    def show
      @returns = @sale.returns
      render json: @sale
      
    end
  
  
    def new
      @sale = Sale.new
    end
  
    def create
        @sale = Sale.new(sale_params)
    
        respond_to do |format|
          if @sale.save
            format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
            format.json { render :show, status: :created, location: @sale }
          else
            format.html { render :new }
            format.json { render json: @sale.errors, status: :unprocessable_entity }
          end
        end
      end
  
    def edit
    end
  
    def update
      if params[:return_request]
        handle_return
      else
        regular_update
      end
    end
  
    private
  
    def regular_update
      if @sale.update(sale_params)
        render json: @sale
      else
        render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def handle_return
      sale = Sale.find(params[:id])
    
      # Check if the sale has not been returned
      unless sale.returned?
        # Check if return quantity is provided
        if params[:return_quantity].present?
          return_quantity = params[:return_quantity].to_i
    
          # Check if the return quantity is less than or equal to the quantity originally bought
          if return_quantity >= 0 && return_quantity <= sale.quantity_sold
            # Update the sale with return details
            sale.update(
              return_quantity: return_quantity,
              returned: true
            )
    
            render json: { message: 'Return processed successfully' }, status: :ok
          else
            render json: { error: 'Invalid return quantity' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Return quantity not provided' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Sale has already been returned' }, status: :unprocessable_entity
      end
    end
    
    
    
    
  
    def destroy
      @sale.destroy
      head :no_content
    end
  
    private
  
    def set_sale
      if params[:id].present? && params[:id] != "search_by_release_order"
        @sale = Sale.find(params[:id])
      end
    end
    
    
  
    def sale_params
      params.require(:sale).permit(:release_id, :inventory_item_id, :quantity_sold, :total_amount, :return_quantity, :returned)
    end
    
  end
  