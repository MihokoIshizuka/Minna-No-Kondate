class CreateMenuComments < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_comments do |t|

      t.timestamps
    end
  end
end
