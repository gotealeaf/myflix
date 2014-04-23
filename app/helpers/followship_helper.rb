module FollowshipHelper
  def create_followship(follower_id, user_initiating_id)
    followee = User.find(follower_id)
    if followee.id != user_initiating_id
      if check_for_existing_followship?(followee, user_initiating_id)
        finalise_followship(followee, user_initiating_id)
        flash[:success] = "You are now successfully following #{followee.fullname}."
      else
        flash[:danger] = "You already are following #{followee.fullname}, you cannot follow them again."
      end
    end
  end

  private

  def check_for_existing_followship?(followee, user_initiating_id)
    number = Followship.where(user_id: user_initiating_id, follower_id: followee.id)
    if number == []
      true
    else
      false
    end
  end

  def finalise_followship(followee, user_initiating_id)
    followship = setup_followship(followee, user_initiating_id)
    followship.save
  end

  def setup_followship(followee, user_initiating_id)
    Followship.new(follower_id: followee.id, user_id: user_initiating_id)
  end
end
