class FixIndexesForInvitable < ActiveRecord::Migration[6.0]
  def up
    # fixing https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/issues/153
    remove_index :users, :invitation_token
    execute 'CREATE UNIQUE NONCLUSTERED INDEX index_users_on_invitation_token ON users (invitation_token) WHERE invitation_token IS NOT NULL;'
  end

  def down
    execute 'DROP INDEX index_users_on_invitation_token ON users;'
    add_index :users, :invitation_token, name: 'index_users_on_invitation_token', unique: true
  end
end
