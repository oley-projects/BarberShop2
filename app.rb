require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
	@clients = Client.all
	@contacts = Contact.all
end

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	Client.create :name => @username, :phone => @phone, :datestamp => @datetime, :barber => @barber, :color => @color

	erb "<h3>Thank you, #{@username}</h3>"
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@mailname = params[:mailname]
	@email = params[:email]
	@content = params[:content]

	Contact.create :mailname => @mailname, :email => @email, :content => @content
	
	erb "<h3>Thank you, #{@mailname}, your message sent successfully</h3>"
end