class AddImageUrlToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :image_url, :string
  end
end
