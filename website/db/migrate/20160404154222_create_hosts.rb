class CreateHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :hosts do |t|
      t.integer :creator_account_id
      t.string :ip
      t.string :code
      t.integer :port
      t.string :comment

      t.timestamps
    end

    add_index :hosts, :creator_account_id
  end
end
