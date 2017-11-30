class DropProfilesAndAddresses < ActiveRecord::Migration[5.1]
  def change
    drop_table :addresses do; end
    drop_table :profiles do;  end
  end
end
