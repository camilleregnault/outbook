class PlacesController < ApplicationController
  # include PgSearch
  # pg_search_scope :search_by_category, against: :category
  # pg_search_scope :search_by_address, against: :address

  def index
    @places = Place.where.not(latitude: nil, longitude: nil)

    if params[:category] != 'Select a category' && params[:address].present?
      @places = Place.where(category: params[:category]).near(params[:address])
    elsif params[:category].present? && params[:category] != 'Select a category'
      @places = Place.where(category: params[:category])
    elsif params[:address].present?
      @places = Place.near(params[:address])
    end
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { place: place }),
        image_url: helpers.asset_url('feuille.png'),
        id: place.id
      }
    end
    skip_policy_scope
  end

  def show
    @place = Place.find(params[:id])
    @booking = Booking.new
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
      flash[:notice] = "Well done! You successfully added a place 🎉 "
      redirect_to dashboard_path(tab: "bookings")
    else
      flash[:alert] = "Oops! 😱 a problem has occurred while creating your place "
      render :new
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    flash[:notice] = "You successfully deleted a place ☠️"
    redirect_to dashboard_path
    authorize @place
  end

  def edit
    @place = Place.find(params[:id])
    authorize @place
  end

  def update
    @place = Place.find(params[:id])
    @place.update(place_params)
    redirect_to dashboard_path
    authorize @place
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :category, :capacity, :photo, :photo2, :photo3)
  end
end
