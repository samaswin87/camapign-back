class CreateMessageLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :message_logs do |t|
      t.string :code
      t.text :message
      t.integer :status, default: 0
      t.references :source, polymorphic: true, null: false
      t.references :integration, polymorphic: true, null: false

      t.timestamps
      
      t.index [ :source_type, :source_id, :integration_type, :integration_id ], name: 'index_message_logs_records'
    end

  end
end
