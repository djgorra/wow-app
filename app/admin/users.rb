ActiveAdmin.register User do
    index do 
        column :id
        column :email
        column :battletag
        column :characters
        column :teams
        column :runs
        column :created_at
        column :updated_at
        actions
    end
end
