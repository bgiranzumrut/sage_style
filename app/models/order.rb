class Order < ApplicationRecord
  STATUSES = %w[new paid shipped]

  validates :status, presence: true, inclusion: { in: STATUSES }
  belongs_to :user, optional: true  # Guest checkout or registered user
  has_many :order_items, dependent: :destroy
  belongs_to :province
  validates :subtotal, :gst, :pst, :hst, :total, presence: true, numericality: true
  validates :address, presence: true


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
