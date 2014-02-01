class UsersController < ApplicationController
  before_action :require_user, only: :update_queue

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Account created successfully, you have been logged in.'
      redirect_to home_path
    else
      render :new
    end
  end

  def update_queue
    if reorder_queue_items && update_queue_item_ratings
      flash[:success] = 'Your queue has been updated successfully.'
    else
      flash[:danger] =
      'There was a problem updating your queue. Please try again.'
    end

    redirect_to :back
  end

  private

  def reorder_queue_items
    transaction_was_successful = true

    current_user.transaction do
      queue_items_in_params_with_parameter(:position).each do |id, parameters|
        queue_item = QueueItem.find(id)
        if parameters[:position] =~ /\A\d+\z/ && queue_item.user == current_user
          queue_item.position = parameters[:position]
          queue_item.save
        else
          transaction_was_successful = false
          raise ActiveRecord::Rollback
        end
      end
      current_user.sort_queue_items_by_position
    end

    transaction_was_successful
  end

  def update_queue_item_ratings
    transaction_was_successful = true

    queue_items_in_params_with_valid_rating = queue_items_in_params_with_parameter(:rating)

    queue_items_in_params_with_valid_rating.delete_if{|_,v| v[:rating].blank?}

    params[:user][:queue_item].select{|_,v|v.include?(:rating) && (1..5).include?(v['rating'].to_i)}

    current_user.transaction do
      queue_items_in_params_with_valid_rating.each do |id, parameters|
        if Review.valid_ratings.include?(parameters[:rating].to_i)
          queue_item = QueueItem.find(id)
          review = Review.find_by_creator_and_video(current_user, queue_item.video)
          if review
            review.rating = parameters[:rating]
          else
            review = Review.new(creator: current_user, video: queue_item.video, rating: parameters[:rating])
          end

          if !review.save(validate: false)
            transaction_was_successful = false
            raise ActiveRecord::Rollback
          end
        else
          transaction_was_successful = false
          raise ActiveRecord::Rollback
        end
      end
    end

    transaction_was_successful
  end

  def queue_items_in_params_with_parameter(parameter)
    params[:user][:queue_item].select{|_,v|v.include?(parameter)}
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
