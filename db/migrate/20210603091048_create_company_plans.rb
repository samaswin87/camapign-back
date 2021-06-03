class CreateCompanyPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :company_plans do |t|
      t.integer :company_id
      t.string  :month
      t.integer :credits, default: 0
      t.integer :additional_credits, default: 0
      t.integer :inbounds, default: 0
      t.integer :outbounds, default: 0
      t.integer :voice_inbounds, default: 0
      t.integer :voice_outbounds, default: 0
      t.integer :availed_inbounds, default: 0
      t.integer :availed_outbounds, default: 0
      t.integer :availed_voice_inbounds, default: 0
      t.integer :availed_voice_outbounds, default: 0

      t.timestamps
    end
    add_index :company_plans, :company_id

    add_foreign_key :company_plans, :companies, column: :company_id
  end
end
