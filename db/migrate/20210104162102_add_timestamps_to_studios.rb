class AddTimestampsToStudios < ActiveRecord::Migration[5.2]
  def change
    add_column :studios, :created_at, :datetime, null: false
    add_column :studios, :updated_at, :datetime, null: false
  end
end
