class Board < ActiveRecord::Base
  belongs_to :client
  has_many :squares
end
