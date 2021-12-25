class AddDancestylesToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :event_dance_style, :integer
  end
end
