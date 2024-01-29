# app/controllers/inventory_items_controller.rb
class InventoryItemsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :index, :destroy, :update]
  skip_before_action :require_login, only: [:create, :index, :show, :destroy, :update]  # Allow unauthenticated access to create, index, and show actions
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @inventory_items = InventoryItem.where("name LIKE ?", "%#{params[:search]}%")
    else
      @inventory_items = InventoryItem.all
    end

    render json: @inventory_items, include: [:releases]
  end

  def show
    render json: @inventory_item, include: [:releases]
  end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)

    if @inventory_item.save
      render json: @inventory_item, status: :created
    else
      render json: { errors: @inventory_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @inventory_item.update(inventory_item_params)
      render json: @inventory_item
    else
      render json: { errors: @inventory_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_quantity
    new_quantity = params[:quantity].to_i
    current_quantity = @inventory_item.quantity

    # Ensure the new quantity won't result in a negative quantity
    if new_quantity > current_quantity
      render json: { errors: ["Cannot subtract more than the current quantity"] }, status: :unprocessable_entity
      return
    end

    updated_quantity = current_quantity - new_quantity

    if @inventory_item.update(quantity: updated_quantity)
      render json: @inventory_item
    else
      render json: { errors: @inventory_item.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def destroy
    @inventory_item.destroy
    head :no_content
  end

  private

  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:id])
  end

  def inventory_item_params
    params.require(:inventory_item).permit(:name, :description, :quantity, :price, :units_per_box, :date_arrival)
  end
end
