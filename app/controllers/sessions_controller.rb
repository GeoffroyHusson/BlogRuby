class SessionsController < ApplicationController
	def create
		if user = User.authenticate(params[:email], params[:password])
			session[:user_id] = user.id
			redirect_to root_path, :notice => "Logged successfully"
		else
			flash.now[:alert] = "Login ou mot de passe incorrect"
			render :action => 'new'
		end
	end

	def destroy
		reset_session
		redirect_to root_path, :notice => "Déconnection avec succès"
	end
end
