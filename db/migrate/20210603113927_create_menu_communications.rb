class CreateMenuCommunications < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_communications do |t|
      t.integer :status, default: 0
      t.integer :recipient_id
      t.text :message

      t.timestamps
    end

    add_index :menu_communications, :recipient_id
    
    add_foreign_key :menu_communications, :menu_recipients, column: :recipient_id
  end
end
