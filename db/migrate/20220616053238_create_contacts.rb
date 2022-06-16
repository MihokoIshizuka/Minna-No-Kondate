class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|

      t.references :member, foreign_key: true
      t.references :admin, foreign_key: true
      t.string :message
      t.string :image
      t.string :source

      t.timestamps
    end
  end
end
