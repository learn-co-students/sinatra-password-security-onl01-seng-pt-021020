require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do #renders an index.erb file with links to signup or login.
		erb :index
	end

	get "/signup" do #renders a form to create a new user. The form includes fields for username and password.renders a form to create a new user. 
		erb :signup
	end

	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])
		if user.save #if the user is saved
		  redirect "/login"
		else #if the user can't be saved
		  redirect "/failure"
		end
	end

	get "/login" do #renders a form for logging in
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
 
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/success"
  else
    redirect "/failure"
   end
	end

	get "/success" do #renders a success.erb page, which should be displayed once a user successfully logs in.
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do #renders a failure.erb page. This will be accessed if there is an error logging in or signing up.
		erb :failure
	end

	get "/logout" do #clears the session data and redirects to the homepage
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
