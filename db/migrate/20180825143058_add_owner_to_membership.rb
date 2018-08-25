class AddOwnerToMembership < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :owner, :boolean
  end
end
