class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :company_id
      t.integer :status, default: 0
      t.string :name
      t.datetime :archived_at

      t.timestamps
    end

    add_index :tags, :company_id
    add_index :tags, :name

    add_foreign_key :tags, :companies, column: :company_id
  end
end
