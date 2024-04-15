ActiveAdmin.register Boss do
    show do 
        attributes_table do
            row :name
            row :items
        end
    end

end
