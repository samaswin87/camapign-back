class CreateCompanySettings < ActiveRecord::Migration[6.1]
  def change
    create_table :company_settings do |t|
      t.integer :messaging_platform, default: 0
      t.text :address
      t.string :batch_process_default_time, default: '12:00 AM UTC'
      t.string :time_zone, default: 'UTC'
      t.integer :company_id
      t.integer :message_length, default: 0
      t.integer :maxuser, default: 0
      t.integer :max_campaign, default: 0
      t.integer :max_workflow, default: 0
      t.integer :max_menu, default: 0
      t.integer :max_contacts_in_campaign, default: 0
      t.boolean :use_short_code, default: false
      t.boolean :use_destination_link, default: false
      t.boolean :notify_credit_limit, default: false
      t.boolean :notify_user_creation, default: false
      t.boolean :notify_campaign_creation, default: false
      t.boolean :notify_workflow_creation, default: false
      t.boolean :notify_menu_creation, default: false
      t.boolean :sso, default: false
      t.boolean :import_workflows, default: false
      t.boolean :import_menus, default: false
      t.boolean :import_users, default: false
      t.boolean :import_contacts, default: false
      t.boolean :import_campaigns, default: false
      t.date :plan_start_date, default: Time.now
      t.date :plan_end_date
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :company_settings, :company_id
    add_index :company_settings, :updated_by_id
    
    add_foreign_key :company_settings, :companies, column: :company_id
    add_foreign_key :company_settings, :users, column: :updated_by_id
  end
end
