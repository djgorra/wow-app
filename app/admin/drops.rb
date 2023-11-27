ActiveAdmin.register Drop do
    permit_params :character_battle_id, :item_id, :disenchanted
    
    index do
        selectable_column
        id_column
        column :character_battle do |drop|
            drop.character_battle.character.name
        end
        column :item
        column :disenchanted
        actions
    end
    
    filter :disenchanted
    
    form do |f|
        f.inputs do
            f.input :disenchanted
        end
        f.actions
    end
end