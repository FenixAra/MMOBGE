require 'digest/md5'

class UsersController < ApplicationController

  def index
    render json: { count: User.count ,users: User.all}
  end

  def info
    render json: User.find_by(id: params[:id])
  end

  def save
    user = JSON.parse(request.body.read)
    action = 'created'
    existing_user = User.find_by(user_name: user["user_name"])
    if existing_user
      if user['password']
        user['password'] = Digest::MD5.hexdigest(user['password'])
      end
      existing_user.update(user)
      action = 'updated'
    else 
      user['password'] = Digest::MD5.hexdigest(user['password'])
      User.create(user)
    end
    render json: {status: action}
  end

  def verify_email_exists
    body = JSON.parse(request.body.read)
    user = User.find_by(email: body["email"])
    if user
      render json: {exists: true}
    else
      render json: {exists: false} 
    end
  end

  def verify_user_name_exists
    body = JSON.parse(request.body.read)
    user = User.find_by(user_name: body["user_name"])
    if user
      render json: {exists: true}
    else
      render json: {exists: false} 
    end
  end

  def login
    login_info = JSON.parse(request.body.read)
    user = User.find_by(user_name: login_info["user_name"])
    puts user
    if user['password'] == Digest::MD5.hexdigest(login_info['password'])
      render json: {id: user.id, message: 'login success', email: user.email, first_name: user.first_name, last_name: user.last_name}
    else
      render json: {message: 'invalid user_name/password'}, :status => 401
    end 
  end

  def change_password
    change_password_info = JSON.parse(request.body.read)
    p change_password_info
    user = User.find_by(id: change_password_info["id"])
    p user
    if !user
      render json: {error: "Invalid user ID"}, :status => 401
    else
      p Digest::MD5.hexdigest(change_password_info[:old_password])
      p Digest::MD5.hexdigest(change_password_info[:new_password])
      if  Digest::MD5.hexdigest(change_password_info[:old_password]) == user[:password]
        user.update({password: Digest::MD5.hexdigest(change_password_info[:new_password])})
      else
        render json: {error: "Incorrect Old password"}, :status => 400
      end
    end
  end
end
