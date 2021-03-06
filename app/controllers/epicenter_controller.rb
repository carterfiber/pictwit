class EpicenterController < ApplicationController

	before_action :authenticate_user!

  include TweetsHelper


  def feed
  	@following_tweets = Array.new

  	Tweet.order(id: :desc).each do |t|
  		if current_user.following.include?(t.user_id) || current_user.id == t.user_id
  			@following_tweets.push(t)
  		end 
      # @following_tweets = @following_tweets.order('created_at' DESC)
  	end
  end

  def show_user
  	@user = User.find(params[:id])
    # @user = User.find_by(params[:username])
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

  def epi_tweet
    # @tweet = Tweet.new

    # @tweet.message = "#{params[:tweet][:message]}"
    # @tweet.user_id = "#{params[:tweet][:user_id].to_i}"

    @tweet = Tweet.create(message: params[:tweet][:message], user_id: params[:tweet][:user_id].to_i)
    @tweet = get_tagged(@tweet) #method from the helper 
    @tweet.save 

    redirect_to root_path
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
    
  end

  def all_users
    @users = User.all
  end

  def following
    @user = User.find(params[:id])
    @users = Array.new

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = Array.new

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end
end
