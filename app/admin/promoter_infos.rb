ActiveAdmin.register PromoterInfo do
  index do                            
    column :name                     
    column :email        
    column :phone           
    column :address
    column :tags           
    default_actions                   
  end           
  
  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :address
      row :tags
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end                      

  filter :email                       
  
  form :partial => "form"
end
