class CreateMenuCommunications < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_communications do |t|

      t.timestamps
    end
  end
end
