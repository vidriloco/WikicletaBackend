ActiveAdmin.register Contact do
  index do                            
    column :email                                 
    default_actions                   
  end                                 

  filter :email                       
  
  show do
    attributes_table do
      row :email
    end
  end
end
