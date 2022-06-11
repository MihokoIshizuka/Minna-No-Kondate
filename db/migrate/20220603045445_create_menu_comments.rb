class CreateMenuComments < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_comments do |t|

      t.references :member, foreign_key: true
      t.references :admin, foreign_key: true
      t.references :menu, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
