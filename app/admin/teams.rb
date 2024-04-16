ActiveAdmin.register Team do
    index do 
        column :id
        column :user
        column :name
        column :characters
        column :faction
        column :runs
        column :created_at
        actions
    end
end