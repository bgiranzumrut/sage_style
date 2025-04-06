class Order < ApplicationRecord
  belongs_to :user, optional: true  # Guest checkout or registered user
  has_many :order_items, dependent: :destroy
  belongs_to :province

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id user_id province_id status subtotal gst pst hst total
      name address created_at updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "province", "order_items"]
  end
end
