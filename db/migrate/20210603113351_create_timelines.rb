class CreateTimelines < ActiveRecord::Migration[6.1]
  def change
    create_table :timelines do |t|
      t.integer :user_id
      t.string :title
      t.string :description

      t.timestamps
    end

    add_index :timelines, :user_id

    add_foreign_key :timelines, :users, column: :user_id
  end
end
