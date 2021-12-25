class AddInstructorIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :instructor_id, :integer
    add_index :events, :instructor_id
  end
end
