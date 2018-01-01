class AddLikesCountToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :likable_count, :integer, default: 0
  end
end
