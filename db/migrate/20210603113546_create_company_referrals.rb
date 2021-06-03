class CreateCompanyReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :company_referrals do |t|
      t.integer :company_id
      t.string :name
      t.string :email
      t.string :phone
      t.string :description
      t.string :contact_person
      t.string :referral_code
      t.integer :status
      t.integer :free_credits

      t.timestamps
    end
  end
end
