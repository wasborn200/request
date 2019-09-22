class AddCollablistToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :collablist, :string
  end
end
