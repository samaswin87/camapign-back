class CreateUserSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.boolean :notify_workflow, default: false
      t.boolean :notify_menu, default: false
      t.boolean :notify_campaign, default: false
      t.boolean :notify_creditlimit, default: false
      t.string :time_zone, default: 'UTC'

      t.timestamps
    end

    add_index :user_settings, :user_id

    add_foreign_key :user_settings, :users, column: :user_id
  end
end
