class AddProfileFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.references :account, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :college
      t.string :hometown
      t.string :lives_in
      t.string :telephone

      t.text :words_live_by
      t.text :about_me

      t.date :birthdate
      t.integer :sexual_id, default: 0
    end
  end
end
