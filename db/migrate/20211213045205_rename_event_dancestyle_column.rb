class RenameEventDancestyleColumn < ActiveRecord::Migration[6.1]
  def up
    rename_column :events, :event_dance_style, :dance_styles
  end
  
  def down 
    rename_column :events, :dance_styles, :event_dance_style
  end
end
