class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :image
      t.text :upper_text
      t.text :lower_text
      t.timestamps
    end
  end
end
