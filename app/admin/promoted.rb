ActiveAdmin.register Promoted do
  index do                            
    column :headline                     
    column :main_details        
    column :extra_details           
    column :promoter_name
    column :likes_count             
    default_actions                   
  end                                 

  filter :email                       
  
  show do
    attributes_table do
      row :headline
      row :main_details
      row :extra_details
      row :promoter_name
      row :likes_count
      #row :image do
      #  image_tag(ad.image.url)
      #end
    end
    render "show"
  end
      
  form :partial => "form"
end
