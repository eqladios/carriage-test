class AddUniqueIndexToMembership < ActiveRecord::Migration[5.1]
  def change
    add_index :memberships, [:user_id, :list_id], unique: true
  end
end
