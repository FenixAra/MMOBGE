require 'digest/md5'

class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    render json: { count: User.count ,users: User.all}
  end

  def save
    @user = JSON.parse(request.body.read)
    @existing_user = User.find_by(user_name: @user["user_name"])
    if @existing_user
      @user['password'] = Digest::MD5.hexdigest(@user['password'])
      @existing_user.update(@user)
    else 
      @user['password'] = Digest::MD5.hexdigest(@user['password'])
      User.create(@user)
    end
    render json: {status: 'created'}
  end

  def verify_email_exists
    @body = JSON.parse(request.body.read)
    @user = User.find_by(email: @body["email"])
    if @user
      render json: {exists: true}
    else
      render json: {exists: false} 
    end
  end

  def verify_user_name_exists
    @body = JSON.parse(request.body.read)
    @user = User.find_by(user_name: @body["user_name"])
    if @user
      render json: {exists: true}
    else
      render json: {exists: false} 
    end
  end

  def login
    puts request.body.read
    @login_info = JSON.parse(request.body.read)
    @user = User.find_by(user_name: @login_info["user_name"])
    puts @user
    if @user['password'] == Digest::MD5.hexdigest(@login_info['password'])
      render json: {message: 'login success'}
    else
      render json: {message: 'invalid user_name/password'}, :status => 401
    end 
  end
end
