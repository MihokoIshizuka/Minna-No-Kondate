class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|

      t.references :member, foreign_key: true
      t.references :group, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
