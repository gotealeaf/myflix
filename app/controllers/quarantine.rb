

  def all_positions_unique?(new_positions)
    positions = []
    new_positions.each do |new_position|
      positions << new_position[":position"]
    end
    positions.uniq.length == positions.length
  end
end


  def update_queue
    new_positions = params[:queue_items]
    if !all_positions_unique?(new_positions)
      flash[:danger] = "Non-unique order numbers entered"
    elsif !all_positions_integers?(new_positions)
      flash[:danger] = "Non-integer order numbers entered"
    else
      current_user.queue_items.each do |queue_item|
        new_positions.each do |position_check|
          if queue_item.id == position_check[":id"].to_i
            require 'pry'; binding.pry
            queue_item.update_column(:position, position_check[":position"].to_i)
          end
        end
      end
    end
    redirect_to my_queue_path
  end
          
            # if position_check[":position"].to_i > current_user.queue_items.length
              # current_user.queue_items.each do |shift_queue_item|
              #   if shift_queue_item.position > current_user.queue_items.find(position_check[":id"]).position
              #     require 'pry'; binding.pry 
              #     shift_queue_item.update_attributes(position: (shift_queue_item.position.to_i - 1))
              #   end
              # end
            #require 'pry'; binding.pry 
            #   queue_item.update_attributes(position: position_check[":position"].to_i)
            # else
