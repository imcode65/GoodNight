class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following_user, class_name: "User"

  validates_uniqueness_of :follower_id, scope: [:following_user_id]
  validate :valid_follow

  private

  def valid_follow
    return if follower_id != following_user_id
    errors.add("User cannot follow him/her self")
  end

end
