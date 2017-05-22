class AddBackgroundcolorToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bg_color, :string
  end
end
