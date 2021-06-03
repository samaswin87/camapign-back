class CreateMenuRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_recipients do |t|

      t.timestamps
    end
  end
end
