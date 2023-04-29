# frozen_string_literal: true

module Docs::UsersControllerDocs
  extend ActiveSupport::Concern

  class_methods do
    def users_index
      return example <<-EOS
        GET /users
        Params
        { "view": "followings" }
        200
        {
          "data": [
                    {
                      "id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                      "name": "John",
                      "sleeps": 2,
                      "followers": 7,
                      "followings": 8
                    },
                    {
                      "id": "62da320e-4b63-4016-bd06-5f882b8382cc",
                      "name": "Wick",
                      "sleeps": 5,
                      "followers": 2,
                      "followings": 15
                    }
                  ]
        }
      EOS
    end
  end
end
