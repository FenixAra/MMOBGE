Rails.application.routes.draw do
  scope '/v1' do
    scope '/users' do
      get '/' => 'users#index'
      post '/' => 'users#save'
      post '/login' => 'users#login'
      post '/email' => 'users#verify_email_exists'
      post '/username' => 'users#verify_user_name_exists'
      post '/change/password' => 'users#change_password'
      get '/:id' => 'users#info'
    end

    scope '/boards' do
      get '/' => 'boards#index'
      post '/' => 'boards#save'
      get '/square/state' => 'boards#get_square_state'
      post '/square/state' => 'boards#update_square_state'
      post '/:id/record' => 'boards#set_record'
      get '/:id' => 'boards#get_board'
    end
  end
end
