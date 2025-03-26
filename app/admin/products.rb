ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id, :featured, :image
  config.comments = false


  filter :has_image, as: :select, label: "Has Image?", collection: [["Yes", true], ["No", false]]

  filter :name
  filter :price
  filter :stock_quantity
  filter :category
  filter :featured

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :featured
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
      f.input :image, as: :file
    end
    f.actions
  end
end
