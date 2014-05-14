class RelationshipsController < AuthenticatedController
  def index
    @relationships = current_user.following_relationships
  end

  def create
    leader = User.find(params[:leader_id])
    @relationship = Relationship.new(leader_id: leader.id, follower_id: current_user.id)
    if @relationship.save
      flash[:success] = "You have followed #{leader.full_name}"
      redirect_to people_path
    else
      @user = leader
      render 'users/show'
    end
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship && current_user == relationship.follower
    redirect_to people_path
  end
end