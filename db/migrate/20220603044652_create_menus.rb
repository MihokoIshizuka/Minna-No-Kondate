class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|

      t.integer :member_id
      t.date :date
      t.text :body
      t.integer :time_zone, default: 0, null: false
      t.timestamps
    end
  end
end
