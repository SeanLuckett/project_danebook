class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :profile, foreign_key: true
      t.string :street1, null: false
      t.string :street2
      t.string :city, null: false
      t.string :state, null: false
      t.string :postcode, null: false

      t.timestamps
    end
  end
end
