class AddDancestylesToInstructors < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :instructor_dance_style, :integer
  end
end
