class ChangePostIdToAllowNull < ActiveRecord::Migration[7.0]
  def change
    change_column :notifications, :post_id, :bigint, null: true
  end
end
