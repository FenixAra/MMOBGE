class User < ActiveRecord::Base
  has_many :board_users
end
