class RestaurantForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :description, :string
  attribute :restaurant_images_attributes
  attribute :restaurant

  def save
    ActiveRecord::Base.transaction do
      restaurant.assign_attributes(name: name, description: description)
      restaurant.save!

      if restaurant_images_attributes.present?
        restaurant_images_attributes.values.each do |restaurant_image_params|
          if restaurant_image_params[:_destroy] == '1'
            restaurant.restaurant_images.find(restaurant_image_params[:id]).destroy!
          end

          if restaurant_image_params[:base64_image].present?
            if restaurant_image_params[:id].present?
              restaurant.restaurant_images.find(restaurant_image_params[:id]).image.attach(data: restaurant_image_params[:base64_image])
            else
              restaurant_image = restaurant.restaurant_images.new
              restaurant_image.image = { data: restaurant_image_params[:base64_image] }
              restaurant_image.save!
            end
          end
        end
      end
    end
    true
  rescue StandardError => e
    p e
    false
  end
end
