class CreateMenuDeclarations < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_declarations do |t|

      t.timestamps
    end
  end
end
