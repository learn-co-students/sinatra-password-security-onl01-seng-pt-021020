require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
		#your code here!
		 user = User.new(:username => params[:username], :password => params[:password])
		 if user.save
      redirect "/login"
     else
      redirect "/failure"
     end
	end

	get "/login" do
		erb :login
	end
	
get "/success" do 
  erb :success
end


	post "/login" do
  user = User.find_by(:username => params[:username])
 
  if user && user.authenticate(params[:password]) 
    session[:id] = user.id
    redirect "/success"
  else
    redirect "/failure"
  end
end


# post "/login" do
#     if !empty_fields? && (@user = User.find_by(username: params[:username]))
#       session[:user_id] = @user.id
#       redirect '/success'
#     else
#       redirect '/failure'
#     end
#   end


	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[user_id]
		end

		def current_user
			User.find(session[user_id])
		end
		
		# def empty_fields?
  #     params[:username].empty? || params[:password].empty?
  #   end

	end

end
