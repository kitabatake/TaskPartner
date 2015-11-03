class Card < ActiveRecord::Base
  has_many :memos, :dependent => :destroy
end
