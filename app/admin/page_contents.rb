ActiveAdmin.register PageContent do
  permit_params :name, :content

  index do
    column :name
    column :content
    actions
  end

  show do
    attributes_table do
      row :name
      row :content
    end
  end

  form do |f|
    f.inputs "Page Content" do
      f.input :name
      f.input :content
    end
    f.actions
  end
end
