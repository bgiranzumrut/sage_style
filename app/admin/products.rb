ActiveAdmin.register Product do
  # Add :on_sale to permitted parameters
  permit_params :name, :description, :price, :stock_quantity, :category_id, :featured, :on_sale, :image

  config.comments = false

  # Filters (including on_sale)
  filter :has_image, as: :select, label: "Has Image?", collection: [["Yes", true], ["No", false]]
  filter :name
  filter :price
  filter :stock_quantity
  filter :category
  filter :featured
  filter :on_sale

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :featured
    column :on_sale
    column "Image?" do |product|
      product.image.attached? ? "Yes" : "No"
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :featured
      f.input :on_sale
      f.input :image, as: :file
    end
    f.actions
  end

  # Show page with scaled image preview
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :featured
      row :on_sale
      row :image do |product|
        if product.image.attached?
          image_tag product.image.variant(resize_to_limit: [300, 300])
        end
      end
    end
  end
end
