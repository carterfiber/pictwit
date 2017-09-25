class EpicenterController < ApplicationController

	before_action :authenticate_user!

  def feed
  	@following_tweets = Array.new

  	Tweet.all.each do |t|
  		if current_user.following.include?(t.user_id) || current_user.id == t.user_id
  			@following_tweets.push(t)
  		end 
  	end
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	# We are adding the user.id of the user you want to 
  # follow to your following array.
  # and we want to make sure it's saved in there as an integer
  current_user.following.push(params[:id].to_i)
  current_user.save

  redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end
end
