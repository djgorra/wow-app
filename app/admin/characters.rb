ActiveAdmin.register Character do
    show do 
        attributes_table do
            row :name
            row :user
            row :team
            row :wishlist_items
            row :drops
            row :created_at
            row :updated_at
        end
    end

    filter :id
end
