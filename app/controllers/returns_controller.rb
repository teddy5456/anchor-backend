# app/controllers/returns_controller.rb

class ReturnsController < ApplicationController
    def create
      @sale = Sale.find(params[:sale_id])
      @return = @sale.returns.build(return_params)
  
      if @return.save
        render json: { message: "Item returned successfully." }
      else
        render json: { error: "Failed to return item.", details: @return.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def return_params
      params.require(:return).permit(:inventory_item_id, :quantity_returned)
    end
  end
  