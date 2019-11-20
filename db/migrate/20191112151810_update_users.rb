class UpdateUsers < ActiveRecord::Migration[5.2]
    def change
      add_column :users, :username, :string, limit: 20, null: false, unique: true, default: 'nickname'
      add_column :users, :provider, :string, limit: 50, null: false, default: ''
      add_column :users, :uid, :string, limit: 500, null: false, default: 'user-id'
      add_column :users, :first_name, :string, limit: 20, null: false,  unique: true, default: 'name'
      add_column :users, :last_name, :string, limit: 20, null: false,  unique: true, default: 'surname'
      add_column :users, :date_of_birth, :date, unique: true, default: '2014-12-01T01:29:18'
      add_column :users, :gender, :string, default: 'others'
      add_column :users, :email, :string, default: 'email@gmail.com'
      add_column :users, :twittername, :string, limit:20, null: false, unique: true, default: 'twitter-name'
    end
end
