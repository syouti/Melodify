class User < ApplicationRecord
  # Devise の設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 投稿機能
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # フォロー機能
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # ユーザーが特定のユーザーをフォローしているか確認するメソッド
  def following?(other_user)
    followings.include?(other_user)
  end

  # ユーザーをフォローするメソッド
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # フォローを解除するメソッド
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
