require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { in: 3..25 }
	validates :phone, presence: true, length: { in: 5..15 }
	validates :datestamp, presence: true, length: { in: 5..15 }
	validates :barber, presence: true, length: { in: 3..30 }
	validates :color, presence: true, length: { in: 2..10 }
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
	#@clients = Client.all
	#@contacts = Contact.all
end

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do
	@c = Client.new params[:client]
	if @c.save
		erb "<h3>Thank you</h3>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
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

get '/barber-:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end