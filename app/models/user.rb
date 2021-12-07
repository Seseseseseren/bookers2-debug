class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :favorites, dependent: :destroy
  
  has_many :book_comments, dependent: :destroy

  has_many :relationships, foreign_key: :followed_id,dependent: :destroy
  has_many :followed, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :followed
  
  has_many :user_rooms, dependent: :destroy
  
has_many :chats, dependent: :destroy

  def is_followed_by?(user)
    reverse_of_relationships.find_by(followed_id: user.id).present?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
