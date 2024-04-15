ActiveAdmin.register User do
    show do 
        attributes_table do
            row :email
            row :characters
            row :created_at
            row :updated_at
        end
    end
end
