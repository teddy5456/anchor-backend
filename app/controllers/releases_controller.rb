# app/controllers/releases_controller.rb
class ReleasesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :index, :destroy, :update]
    skip_before_action :require_login, only: [:create, :index, :show, :destroy, :update]
  
    before_action :set_release, only: [:show, :edit, :update, :destroy]
  
    def index
      @releases = Release.includes(:inventory_items).all
      render json: @releases, include: [:inventory_items]
    end
  
    def show
      render json: @release, include: [:inventory_items]
    end
  
    def new
      @release = Release.new
    end
  
    def create
      @release = Release.new(release_params)
  
      if @release.save
        render json: @release, status: :created, location: @release
      else
        render json: @release.errors, status: :unprocessable_entity
      end
    end
      
  
    def edit
    end
  
    def update
      if @release.update(release_params)
        redirect_to @release, notice: 'Release was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @release.destroy
      redirect_to releases_url, notice: 'Release was successfully destroyed.'
    end
  
    private
  
    def set_release
      @release = Release.find(params[:id])
    end
  

    def release_params
      params.require(:release).permit(:client_name, :order_ref, :location, joins_attributes: [:id, :inventory_item_id])
    end
    
    end
  