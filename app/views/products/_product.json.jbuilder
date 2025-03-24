json.extract! product, :id, :name, :description, :price, :stock_quantity, :category_id, :image_url, :created_at, :updated_at
json.url product_url(product, format: :json)
