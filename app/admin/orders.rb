ActiveAdmin.register Order do
  includes :user, :province, order_items: :product

  permit_params :status, :name, :address, :province_id, :user_id, :subtotal, :gst, :pst, :hst, :total

  index do
    selectable_column
    id_column
    column :created_at
    column :status
    column("Customer") { |order| "#{order.user.first_name} #{order.user.last_name}" }
    column("Email")    { |order| order.user.email }
    column("Province") { |order| order.province.name }
    column :subtotal
    column :gst
    column :pst
    column :hst
    column :total
    actions
  end

  filter :status
  filter :created_at

  show do
    panel "Customer Info" do
      attributes_table_for order.user do
        row :first_name
        row :last_name
        row :email
      end
    end

    panel "Order Details" do
      attributes_table_for order do
        row :id
        row :status
        row :created_at
        row("Province") { order.province.name }
        row :address
        row :subtotal
        row :gst
        row :pst
        row :hst
        row :total
      end
    end

    panel "Products Ordered" do
      table_for order.order_items do
        column("Product")    { |item| item.product.name }
        column("Qty")        { |item| item.quantity }
        column("Unit Price") { |item| number_to_currency(item.unit_price) }
        column("Subtotal")   { |item| number_to_currency(item.unit_price * item.quantity) }
      end
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :status, as: :select, collection: Order::STATUSES
      f.input :name
      f.input :address
      f.input :province
      f.input :user
    end
    f.actions
  end
end
