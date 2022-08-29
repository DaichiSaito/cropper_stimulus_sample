class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @form = RestaurantForm.new(restaurant: Restaurant.new)
    @form.restaurant.restaurant_images << RestaurantImage.new
  end

  def create
    @form = RestaurantForm.new(restaurant_params.merge(restaurant: Restaurant.new))
    if @form.save
      redirect_to edit_restaurant_path(@form.restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    restaurant = Restaurant.find(params[:id])
    @form = RestaurantForm.new(restaurant: restaurant)
    if @form.restaurant.restaurant_images.size == 0
      @form.restaurant.restaurant_images << RestaurantImage.new
    end
  end

  def update
    restaurant = Restaurant.find(params[:id])

    @form = RestaurantForm.new(restaurant_params.merge(restaurant: restaurant))
    if @form.save
      redirect_to edit_restaurant_path(@form.restaurant)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, restaurant_images_attributes: [:id, :image, :_destroy, :base64_image])
  end
end
