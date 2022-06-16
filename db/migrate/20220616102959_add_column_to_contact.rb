class AddColumnToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :role, :string
  end
end
