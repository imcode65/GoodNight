module Docs::Users::FollowsControllerDocs
  extend ActiveSupport::Concern

  class_methods do

    def user_follows_user_details
      return example <<-EOS
        GET /users/:user_id/follows
        Params
        { "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4" }
        200
        {
          "data": {
                    "follows": 7,
                    "following": 5,
                    "sleeps": 4
                  }
        }
        404
        {
          "error": true,
          "message": "User not found!"
        }
      EOS
    end

    def user_follows_create
      return example <<-EOS
        POST /users/:user_id/follows
        Params
        { "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4" }
        Payload
        { "following_user_id": "evmd91d1-8878-4203-a344-820cf66ca6g5" }
        200
        {
          message: "You started following Reeves"
        }
        404
        {
          "error": true,
          "message": "User not found!"
        }
        422
        {
          "error": true,
          "message": { "base": ["User cannot follow him/her self"] }
        }
        or
        {
          "error": true,
          "message": "You cannot make any changes to another user"
        }
      EOS
    end

    def user_follows_destroy
      return example <<-EOS
        DELETE /users/:user_id/follows
        Params
        { "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4" }
        Payload
        { "id": "evmd91d1-8878-4203-a344-820cf66ca6g5" }
        200
        {
          message: "You have unfollowed Reeves"
        }
        404
        {
          "error": true,
          "message": "User not found!"
        }
        422
        {
          "error": true,
          "message": { "base": ["Can't unfollow a non-following user"] }
        }
        or
        {
          "error": true,
          "message": "You cannot make any changes to another user"
        }
      EOS
    end

  end
end