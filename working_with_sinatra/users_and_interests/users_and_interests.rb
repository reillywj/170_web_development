require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'psych'
require 'pry'

helpers do
  def display_interests(user)
    user[:interests].join(', ')
  end

  def number_of_users
    @users.size
  end

  def number_of_interests
    count = 0
    @users.each do |name, info|
      count += info[:interests].size
    end
    count
  end
end

before do
  @users = Psych.load(File.read('users.yaml'))
end

get '/' do 
  redirect '/users'
end

get '/users' do
  @title = 'Users'

  erb :index
end

get '/:username' do
  @user_name = params['username']
  @title = "User: #{@user_name.capitalize}"
  @user = @users[@user_name.to_sym]
  erb :user
end