class AddListRefToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :list, foreign_key: true
  end
end
