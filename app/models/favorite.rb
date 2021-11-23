class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :book
  
  validates_uniqueness_of :book_id, scope: :user_id
  #上が無くても挙動は問題なかった。

  
end
