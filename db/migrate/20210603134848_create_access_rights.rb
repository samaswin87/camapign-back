class CreateAccessRights < ActiveRecord::Migration[6.1]
  def change
    create_table :access_rights do |t|
      t.string :module_name
      t.boolean :create, default: false
      t.boolean :show, default: false
      t.boolean :list, default: false
      t.boolean :edit, default: false
      t.boolean :menu, default: false
      t.string :logo
      t.references :source, polymorphic: true, null: false

      t.timestamps
    end
  end
end
