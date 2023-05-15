class ChangeUserIndexesToSqlServer < ActiveRecord::Migration[6.0]
  def up
    # fixing https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/issues/153
    remove_index :users, :reset_password_token
    execute 'CREATE UNIQUE NONCLUSTERED INDEX index_users_on_reset_password_token ON users (reset_password_token) WHERE reset_password_token IS NOT NULL;'
  end

  def down
    execute 'DROP INDEX index_users_on_reset_password_token ON users;'
    add_index :users, :reset_password_token, name: 'index_users_on_reset_password_token', unique: true
  end
end
