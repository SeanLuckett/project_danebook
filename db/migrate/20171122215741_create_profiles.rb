class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :college
      t.string :hometown
      t.string :telephone
      t.date :birthdate
      t.integer :sexual_id, default: 0

      t.timestamps
    end
  end
end
