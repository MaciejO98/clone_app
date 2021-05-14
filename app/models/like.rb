class Like < ApplicationRecord
  belongs_to :post_id
  belongs_to :user_id
  validates :user_id, uniqueness: {scope: :post_id}
end
