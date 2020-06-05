class AddTextColorToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :text_color, :string
  end
end
