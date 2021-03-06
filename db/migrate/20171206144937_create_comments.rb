class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.string :body, null: false
      t.integer :likable_count, default: 0

      t.timestamps
    end
  end
end
