class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :email
      t.string :session_token
      t.datetime :timestamps

      t.timestamps null: false
    end
  end
end
