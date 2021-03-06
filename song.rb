require 'dm-core'
require 'dm-migrations'
class Song
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date
	def released_on=date
		super Date.strptime(date, '%m/%d/%Y')
	end
end
DataMapper.finalize

get '/songs' do 
	@songs = Song.all 
	erb :songs
end

get '/songs/new' do 
	#only 'frank sinatra' can create new songs
	halt(401, 'Not Authorized, log in to do this action') unless session[:admin] 
	@song = Song.new
	erb :new_song
end

get '/songs/:id' do 
	@song = Song.get(params[:id])
	erb :show_song
end

get '/songs/:id/edit' do
	@song = Song.get(params[:id])
	erb :edit_song
end

post '/songs' do
	song = Song.create(params[:song])
	redirect to("/songs/#{song.id}")
end

put '/songs/:id' do 
	song = Song.get(params[:id])
	song.update(params[:song])
	redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
	song = Song.get (params[:id])
	song.destroy
	redirect to("/songs")
end