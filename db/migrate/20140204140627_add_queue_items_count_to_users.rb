class AddQueueItemsCountToUsers < ActiveRecord::Migration
  #railscasts 23
  def change
    add_column :users, :queue_items_count, :integer, default: 0, null: false
    User.reset_column_information
    User.find_each(select: 'id') do |result|
      User.reset_counters(result.id, :queue_items)
    end
  end
end
