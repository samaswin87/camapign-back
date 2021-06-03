class CreateMenuDepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_depositories do |t|

      t.timestamps
    end
  end
end
