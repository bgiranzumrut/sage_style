class PageContent < ApplicationRecord
  validates :name, :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name content created_at updated_at]
  end
end
