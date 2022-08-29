class Restaurant < ApplicationRecord
  has_many :restaurant_images, dependent: :destroy
  accepts_nested_attributes_for :restaurant_images, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
