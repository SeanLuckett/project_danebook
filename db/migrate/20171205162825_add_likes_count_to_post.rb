class AddLikesCountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likable_count, :integer, default: 0
  end
end
