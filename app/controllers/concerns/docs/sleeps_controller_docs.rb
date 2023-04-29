module Docs::SleepsControllerDocs
  extend ActiveSupport::Concern

  class_methods do

    def sleeps_index
      return example <<-EOS
        GET /sleeps
        200
        {
          "data": [
                    {
                      "id": "66cfbef7-29d4-4339-a8fc-e0eda2465794",
                      "start_time": "2023-04-21T11:02:31.370Z",
                      "end_time": "2023-04-21T20:02:31.371Z",
                      "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                      "record_started_at": "2023-04-21T21:02:31.399Z",
                      "total_sleep_time": "9.0 hours"
                    },
                    {
                      "id": "71af31e4-104b-4785-a0c5-99d382fce81c",
                      "start_time": "2023-04-21T22:05:00.000Z",
                      "end_time": "2023-04-22T07:24:00.000Z",
                      "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                      "record_started_at": "2023-04-21T18:33:31.286Z",
                      "total_sleep_time": "9.32 hours"
                    }
                  ]
        }
      EOS
    end

    def sleeps_show
      return example <<-EOS
        GET /sleeps/:id
        Params
        { id: "66cfbef7-29d4-4339-a8fc-e0eda2465794" }
        200
        {
          "data": {
                    "id": "66cfbef7-29d4-4339-a8fc-e0eda2465794",
                    "start_time": "2023-04-21T11:02:31.370Z",
                    "end_time": "2023-04-21T20:02:31.371Z",
                    "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                    "record_started_at": "2023-04-21T21:02:31.399Z",
                    "total_sleep_time": "9.0 hours"
                  }
        }
        404
        {
          "error": true,
          "message": "Sleep not found!"
        }
      EOS
    end

    def sleeps_create
      return example <<-EOS
        POST /sleeps
        Payload
        { 
          "start_time": "21 Apr 2023 11:02:31 AM", 
          "end_time": "21 Apr 2023 08:02:31 PM"
        }
        200
        {
          "data": {
                    "id": "66cfbef7-29d4-4339-a8fc-e0eda2465794",
                    "start_time": "2023-04-21T11:02:31.370Z",
                    "end_time": "2023-04-21T20:02:31.371Z",
                    "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                    "record_started_at": "2023-04-21T21:02:31.399Z",
                    "total_sleep_time": "9.0 hours"
                  }
        }
        422
        {
          "error": true,
          "message": {
                       "base": ["Start Time should always be lesser than the End Time"],
                       "start_time": ["can't be blank"],
                       "end_time": ["can't be blank"]
                     }
        }
      EOS
    end

    def sleeps_update
      return example <<-EOS
        POST /sleeps/:id
        Params
        { "id": "66cfbef7-29d4-4339-a8fc-e0eda2465794" }
        Payload
        { 
          "start_time": "21 Apr 2023 11:02:31 AM", 
          "end_time": "21 Apr 2023 10:02:31 PM"
        }
        200
        {
          "data": {
                    "id": "66cfbef7-29d4-4339-a8fc-e0eda2465794",
                    "start_time": "2023-04-21T11:02:31.370Z",
                    "end_time": "2023-04-21T22:02:31.371Z",
                    "user_id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                    "record_started_at": "2023-04-21T21:02:31.399Z",
                    "total_sleep_time": "11.0 hours"
                  }
        }
        422
        {
          "error": true,
          "message": {
                       "base": ["Start Time should always be lesser than the End Time"],
                       "start_time": ["can't be blank"],
                       "end_time": ["can't be blank"]
                     }
        }
        404
        {
          "error": true,
          "message": "Sleep not found!"
        }
      EOS
    end

    def sleep_destroy
      return example <<-EOS
        DELETE /sleeps/:id
        Params
        { "id": "66cfbef7-29d4-4339-a8fc-e0eda2465794" }
        200
        {
          "message": "Sleep deleted successfully"
        }
        404
        {
          "error": true,
          "message": "Sleep not found!"
        }
      EOS
    end

    def sleep_sleep_reports
      return example <<-EOS
        GET /sleep_reports
        200
        {
          "data": [
                    {
                      "id": "fcfd91d1-8878-4203-a344-820cf66ca7c4",
                      "name": "John",
                      "start_time": "2023-04-21T11:02:31.370Z",
                      "end_time": "2023-04-21T20:02:31.371Z",
                      "duration": "9.0 hours"
                    },
                    {
                      "id": "evmd91d1-8878-4203-a344-820cf66ca8g7",
                      "name": "Keenu",
                      "start_time": "2023-04-21T9:22:20.370Z",
                      "end_time": "2023-04-21T20:02:31.371Z",
                      "duration": "10.75 hours"
                    }
                  ]
        }
      EOS
    end
  end
end