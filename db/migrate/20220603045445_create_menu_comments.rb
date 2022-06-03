class CreateMenuComments < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_comments do |t|

      t.integer :member_id
      t.integer :menu_id
      t.string :comment

      t.timestamps
    end
  end
end
