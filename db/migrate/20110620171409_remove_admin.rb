class RemoveAdmin < ActiveRecord::Migration
  def self.up
    drop_table :admins
  end

  def self.down
    create_table admins do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
  end

    add_index :admins, :email, :unique => true
    add_index :admins, :reset_password_token, :unique => true
  end
end
