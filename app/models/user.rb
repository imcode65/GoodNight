class User < ApplicationRecord
  has_many :received_follows, foreign_key: :following_user_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :following_user

  has_many :sleeps

  def self.sleep_report(days = 7)
    self.joins('left join sleeps on sleeps.user_id = follows.following_user_id')
        .where('sleeps.created_at >= ?', Date.today - days.days)
        .select('users.id user_id, users.name as user_name, sleeps.start_time, sleeps.end_time, ROUND(EXTRACT(EPOCH FROM (sleeps.end_time - sleeps.start_time)) / 3600.0, 2) duration')
        .order('duration desc, sleeps.created_at')
  end

end
