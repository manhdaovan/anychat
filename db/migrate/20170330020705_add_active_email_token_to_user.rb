class AddActiveEmailTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active_email_digest, :string, default: ''
    add_column :users, :receive_msg_offline, :boolean, default: false
  end
end
