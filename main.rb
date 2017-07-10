require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require './song'
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