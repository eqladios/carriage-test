class ChangeMembershipOwnerDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(
      :memberships,
      :owner,
      from: nil,
      to: "false"
    )
  end
end
