class Board < ActiveRecord::Base
  belongs_to :client
  has_many :squares
  has_many :board_users
end
