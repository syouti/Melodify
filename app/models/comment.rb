class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # バリデーションの追加
  validates :content, presence: true, length: { maximum: 500 }
end
