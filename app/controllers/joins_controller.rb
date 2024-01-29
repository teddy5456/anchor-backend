# app/controllers/joins_controller.rb
class JoinsController < ApplicationController
    before_action :set_join, only: [:show, :edit, :update, :destroy]
  
    def index
      @joins = Join.all
    end
  
    def show
    end
  
    def new
      @join = Join.new
    end
  
    def create
      @join = Join.new(join_params)
      if @join.save
        redirect_to @join, notice: 'Join was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @join.update(join_params)
        redirect_to @join, notice: 'Join was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @join.destroy
      redirect_to joins_url, notice: 'Join was successfully destroyed.'
    end
  
    private
  
    def set_join
      @join = Join.find(params[:id])
    end
  
    def join_params
      params.require(:join).permit(:release_id, :inventory_item_id)  # Adjust attributes as per your model
    end
  end
  