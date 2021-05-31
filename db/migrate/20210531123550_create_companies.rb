class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :planCredit
      t.boolean :callForwarding
      t.boolean :messageForward
      t.integer :totalCredits
      t.integer :remainingCredits
      t.integer :creditPercentage
      t.string :apiToken
      t.integer :plan
      t.integer :status
      
      t.timestamps
    end
  end
end
