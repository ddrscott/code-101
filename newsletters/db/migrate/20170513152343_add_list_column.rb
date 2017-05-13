class AddListColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :subscribers, :list, :string
  end
end
