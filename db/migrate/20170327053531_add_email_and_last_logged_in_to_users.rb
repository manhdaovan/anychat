class AddEmailAndLastLoggedInToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_logged_in, :datetime, default: nil
    add_column :users, :email, :string, limit: 255, default: ''
  end
end
