class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to articles_path, :notice => 'User successfully added.'
		else
			render :action => 'new'
		end
	end
	def edit
		@user = current_user
	end
	def update
		@user = current_user
		if @user.update_attributes(user_params)
			redirect_to articles_path, :notice => 'Update user information successfully'
		else
			render :action => 'edit'
		end
	end

	private
		def user_params 
			params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
		end
end
