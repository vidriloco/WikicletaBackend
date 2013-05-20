ActiveAdmin.register Sticker do     
  index do                            
    column :code
    column :available?
    default_actions                   
  end                                 

  filter :code                   

  form :partial => "form" 
                            
  show do
    attributes_table :code, :details, :fake, :banned, :created_at, :updated_at
    render "show"
  end
end                                   
