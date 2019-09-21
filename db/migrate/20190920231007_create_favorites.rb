class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :favlist, foreign_key: true
      t.references :micropost, foreign_key: true

      t.timestamps
    end
  end
end
