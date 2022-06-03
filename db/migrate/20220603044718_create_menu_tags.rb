class CreateMenuTags < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_tags do |t|

      t.integer :menu_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
