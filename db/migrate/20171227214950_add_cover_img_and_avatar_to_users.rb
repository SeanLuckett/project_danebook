class AddCoverImgAndAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar, :string
    add_column :users, :cover_img, :string
  end
end
