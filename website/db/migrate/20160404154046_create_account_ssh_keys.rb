class CreateAccountSshKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :account_ssh_keys do |t|
      t.belongs_to :account, foreign_key: true
      t.string :title
      t.string :cat
      t.text :content
      t.string :comment

      t.timestamps
    end
  end
end