class CreateCompanyReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :company_referrals do |t|
      t.integer :company_id
      t.integer :status, default: 0
      t.string :name
      t.string :email
      t.string :phone
      t.string :description
      t.string :contact_person
      t.string :referral_code
      t.integer :free_credits, default: 0

      t.timestamps
    end

    add_index :company_referrals, :company_id

    add_foreign_key :company_referrals, :companies, column: :company_id
  end
end
