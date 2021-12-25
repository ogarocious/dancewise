class CreateGiraffes < ActiveRecord::Migration[6.1]
  def change
    create_table :giraffes do |t|

      t.timestamps
    end
  end
end
