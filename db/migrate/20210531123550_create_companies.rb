class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string    :name, :null => false
      t.string    :email, :null => false
      t.string    :phone, :null => false
      t.integer   :plan_credits, default: 0
      t.boolean   :call_forwarding, default: :false
      t.boolean   :message_forward, default: :false
      t.integer   :total_credits, default: 0
      t.integer   :remaining_credits, default: 0
      t.integer   :credit_percentage, default: 0
      t.string    :api_token
      t.integer   :plan, default: 1
      t.integer   :status, default: 0
      
      t.timestamps
    end

    add_index :companies, :name,                unique: true
    add_index :companies, :email,               unique: true
    add_index :companies, :phone,               unique: true
    add_index :companies, :status
    add_index :companies, :plan
  end
end
