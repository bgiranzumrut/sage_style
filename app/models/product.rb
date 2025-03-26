class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  scope :featured, -> { where(featured: true).limit(9) }

  # 🔧 For custom image presence filter
  def self.ransackable_attributes(auth_object = nil)
    super + ['has_image']
  end

  def self.ransackable_associations(auth_object = nil)
    super - ['image_attachment', 'image_blob'] # avoid errors
  end

  # Virtual attribute used in filtering
  def has_image
    image.attached?
  end
end
