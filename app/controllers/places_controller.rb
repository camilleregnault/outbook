class PlacesController < ApplicationController
  def index
    @places = Place.all
    skip_policy_scope
  end

  def show
    @place = Place.find(params[:id])
    authorize @place
  end

  def new
    @place = Place.new
    authorize @place
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    authorize @place
    if @place.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :category, :capacity, :photo)
  end
end
