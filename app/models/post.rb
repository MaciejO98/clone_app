class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :title, presence: true, length: { minimum: 6, maximum:100 }
  validates :description, presence: true, length: { minimum: 10, maximum:300 }

  def liked?(user)
    !!self.likes.find {|like| like.user_id == user.id}
  end

end