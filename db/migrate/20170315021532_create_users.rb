class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 100
      t.string :password_digest
      t.timestamps
      t.index :username, unique: true
    end
  end
end
