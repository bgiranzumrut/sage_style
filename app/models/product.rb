class Product < ApplicationRecord
  belongs_to :category

  # Optional: add basic validations
  validates :name, :description, :price, :stock_quantity, presence: true
end
