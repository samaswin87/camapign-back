class CreateMenuPrompts < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_prompts do |t|

      t.timestamps
    end
  end
end
