class CreateFavlists < ActiveRecord::Migration[5.1]
  def change
    create_table :favlists do |t|
      t.string :title
      t.text :memo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
