ActiveAdmin.register Sticker do     
  index do                            
    column :code
    column :available?
    default_actions                   
  end                                 

  filter :code
  filter :status, :as => :check_boxes, :collection => proc { [1 ,2] }, :label => "Available (1) / Taken (2)"

  form :partial => "form" 
                            
  show do
    attributes_table :code, :details, :fake, :banned, :created_at, :updated_at
    render "show"
  end
end                                   