class User < ApplicationRecord
  has_many :received_follows, foreign_key: :following_user_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :following_user

  has_many :sleeps

end
