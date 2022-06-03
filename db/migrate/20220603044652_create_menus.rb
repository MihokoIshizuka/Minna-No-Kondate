class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|

      t.date :date
      t.text :body
      t.timestamps
    end
  end
end
