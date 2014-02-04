class AddQueueItemsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :queue_items_count, :integer, default: 0
    User.rest_column_information
    User.find(:all).each do |user|
      user.update_attributes(queue_items_count: user.queue_items.length)
    end
  end
end
