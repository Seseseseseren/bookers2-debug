class BookComment < ApplicationRecord
  before_action :authenticate_user!

  belongs_to :user
  belongs_to :book
  
  validates :comment, presence: true
end
