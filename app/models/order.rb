class Order < ApplicationRecord
  belongs_to :user, optional: true  # Guest checkout or registered user
  has_many :order_items, dependent: :destroy
  belongs_to :province
end
