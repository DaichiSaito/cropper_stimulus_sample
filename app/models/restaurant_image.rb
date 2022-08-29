class RestaurantImage < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  belongs_to :restaurant
  has_one_base64_attached :image
  attribute :base64_image

  validates :image, presence: true
end
