class AddMobileToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mobile, :string
  end
end
