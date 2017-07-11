require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require './song'
configure do 
	enable :sessions
	set :username, 'frank' 
	set :password, 'sinatra'
end
get '/login' do 
	erb :login
end
post '/login' do 
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		erb :login
	end
end
get '/logout' do
session.clear
redirect to ('/login')
end

get '/set/:name' do 
	session[:name]= params[:name]
end
get '/get/hello' do 
	"Hello #{session[:name]}"
end
get ('/styles.css') do 
	scss :styles
end

get '/' do 
	erb :home
end

get '/about' do
	@title = "Classy Sinatra"
	erb :about
end

get '/contact' do 
	@title = "Contact Me!"
	erb :contact
end

not_found do 
	@title = "404"
	erb :not_found
end