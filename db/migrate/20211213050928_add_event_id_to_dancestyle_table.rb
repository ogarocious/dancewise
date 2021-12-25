class AddEventIdToDancestyleTable < ActiveRecord::Migration[6.1]
  def change
    add_column :dance_styles, :event_id, :integer  
  end
end
