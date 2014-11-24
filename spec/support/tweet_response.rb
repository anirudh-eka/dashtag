module SampleTweetResponses
  def self.tweet_response_with_youtube
    @@tweet_response_with_youtube = {
        "statuses" => [
          {
            "entities" => {
              "urls" => [
              {
                "url" => "http://t.co/npprk1guZR",
                "expanded_url" => "http://youtu.be/lmnop",
                "display_url" => "youtu.be/lmnop"
              },
              {
                "url" => "http://t.co/udp1Px9fLM",
                "expanded_url" => "http://youtube.com/abcde",
                "display_url" => "youtube.com/abcde"
              }],
            },
            "text" => "watch these videos! http://t.co/npprk1guZR http://t.co/udp1Px9fLM",
          }
        ]
      }
  end

  def self.tweet_response_with_image
    @@tweet_response_with_image = {
        "statuses" => [
          {
            "id_str" => "249292149810667520",
            "entities" => {
              "media" => [{
                "indices"=>[71, 93],
                "media_url"=>"http://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
                "media_url_https"=>"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
                "url"=>"http://t.co/8EO3BWutLc",
                "display_url"=>"pic.twitter.com/8EO3BWutLc",
                "expanded_url"=>"http://twitter.com/scumbling/status/471376390852317184/photo/1",
                "type"=>"photo",
              }],
              "urls" => [ ], "hashtags" => [ ]
            },
            "text" => "here's a photo about something! http://t.co/8EO3BWutLc",
          }
        ]
      }
  end

  def self.tweets_with_censored_words
  @@tweets_with_censored_words = {
      "statuses" => [
        {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Fri Sep 21 23:40:54 +0000 2012",
          "id_str" => "249292149810667520",
          "entities" => {
            "media" => [{
              "id"=>471376386016686080,
              "id_str"=>"471376386016686080",
              "indices"=>[71, 93],
              "media_url"=>"http://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
              "media_url_https"=>"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
              "url"=>"http://t.co/8EO3BWutLc",
              "display_url"=>"pic.twitter.com/8EO3BWutLc",
              "expanded_url"=>"http://twitter.com/scumbling/status/471376390852317184/photo/1",
              "type"=>"photo",
              "sizes"=>{
                "medium"=>{"w"=>600, "h"=>600, "resize"=>"fit"},
                "thumb"=>{"w"=>150, "h"=>150, "resize"=>"crop"},
                "large"=>{"w"=>960, "h"=>960, "resize"=>"fit"},
                "small"=>{"w"=>340, "h"=>340, "resize"=>"fit"}
                }
            }],
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "NAAwayDay",
                "indices" => [
                  20,
                  34
                ]
              }
            ],
            "user_mentions" => [

            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "#{ENV["CENSORED_WORDS"].split("|").sample()} #NAAwayDay",
          "metadata" => {
            "iso_language_code" => "pl",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249292149810667520,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "DDFFCC",
            "profile_sidebar_border_color" => "BDDCAD",
            "profile_background_tile" => true,
            "name" => "Chaz Martenstein",
            "profile_image_url" => "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "created_at" => "Tue Apr 07 19:05:07 +0000 2009",
            "location" => "Durham, NC",
            "follow_request_sent" => nil,
            "profile_link_color" => "0084B4",
            "is_translator" => false,
            "id_str" => "29516238",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "http://bullcityrecords.com/wnng/",
                    "indices" => [
                      0,
                      32
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [

                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 8,
            "url" => "http://bullcityrecords.com/wnng/",
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "utc_offset" => -18000,
            "id" => 29516238,
            "profile_use_background_image" => true,
            "listed_count" => 118,
            "profile_text_color" => "333333",
            "lang" => "en",
            "followers_count" => 2052,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "profile_background_color" => "9AE4E8",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "You will come to Durham, North Carolina. I will sell you some records then, here in Durham, North Carolina. Fun will happen.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "statuses_count" => 7579,
            "friends_count" => 348,
            "following" => nil,
            "show_all_inline_media" => true,
            "screen_name" => "bullcityrecords"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
        ################################################################
        {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Fri Sep 21 23:30:20 +0000 2012",
          "id_str" => "249289491129438208",
          "entities" => {
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "NAAwayDay",
                "indices" => [
                  29,
                  43
                ]
              }
            ],
            "user_mentions" => [
            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "#{ENV["CENSORED_WORDS"].split("|").sample()} #NAAwayDay",
          "metadata" => {
            "iso_language_code" => "en",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249289491129438208,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "99CC33",
            "profile_sidebar_border_color" => "829D5E",
            "profile_background_tile" => false,
            "name" => "Thomas John Wakeman",
            "profile_image_url" => "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
            "created_at" => "Tue Sep 01 21:21:35 +0000 2009",
            "location" => "Kingston New York",
            "follow_request_sent" => nil,
            "profile_link_color" => "D02B55",
            "is_translator" => false,
            "id_str" => "70789458",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "",
                    "indices" => [
                      0,
                      0
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [
                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 19,
            "url" => nil,
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
            "utc_offset" => -18000,
            "id" => 70789458,
            "profile_use_background_image" => true,
            "listed_count" => 1,
            "profile_text_color" => "3E4415",
            "lang" => "en",
            "followers_count" => 63,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/images/themes/theme5/bg.gif",
            "profile_background_color" => "352726",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "Science Fiction Writer, sort of. Likes Superheroes, Mole People, Alt. Timelines.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/images/themes/theme5/bg.gif",
            "statuses_count" => 1048,
            "friends_count" => 63,
            "following" => nil,
            "show_all_inline_media" => false,
            "screen_name" => "MonkiesFist"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
      ],
      "search_metadata" => {
        "max_id" => 250126199840518145,
        "since_id" => 24012619984051000,
        "refresh_url" => "?since_id=250126199840518145&q=%23NAAwayDay&result_type=mixed&include_entities=1",
        "next_results" => "?max_id=249279667666817023&q=%23NAAwayDay&count=4&include_entities=1&result_type=mixed",
        "count" => 4,
        "completed_in" => 0.035,
        "since_id_str" => "24012619984051000",
        "query" => "%23NAAwayDay",
        "max_id_str" => "250126199840518145"
      }
  ############
    }
  end

  def self.user_tweet_response
  @@user_tweet_response = {
      "statuses" => [
        {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Fri Sep 21 23:40:54 +0000 2012",
          "id_str" => "249292149810667520",
          "entities" => {
            "media" => [{
              "id"=>471376386016686080,
              "id_str"=>"471376386016686080",
              "indices"=>[71, 93],
              "media_url"=>"http://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
              "media_url_https"=>"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
              "url"=>"http://t.co/8EO3BWutLc",
              "display_url"=>"pic.twitter.com/8EO3BWutLc",
              "expanded_url"=>"http://twitter.com/scumbling/status/471376390852317184/photo/1",
              "type"=>"photo",
              "sizes"=>{
                "medium"=>{"w"=>600, "h"=>600, "resize"=>"fit"},
                "thumb"=>{"w"=>150, "h"=>150, "resize"=>"crop"},
                "large"=>{"w"=>960, "h"=>960, "resize"=>"fit"},
                "small"=>{"w"=>340, "h"=>340, "resize"=>"fit"}
                }
            }],
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "NAAwayDay",
                "indices" => [
                  20,
                  34
                ]
              }
            ],
            "user_mentions" => [

            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "TWITTER USER TWEETS",
          "metadata" => {
            "iso_language_code" => "pl",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249292149810667520,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "DDFFCC",
            "profile_sidebar_border_color" => "BDDCAD",
            "profile_background_tile" => true,
            "name" => "Chaz Martenstein",
            "profile_image_url" => "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "created_at" => "Tue Apr 07 19:05:07 +0000 2009",
            "location" => "Durham, NC",
            "follow_request_sent" => nil,
            "profile_link_color" => "0084B4",
            "is_translator" => false,
            "id_str" => "29516238",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "http://bullcityrecords.com/wnng/",
                    "indices" => [
                      0,
                      32
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [

                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 8,
            "url" => "http://bullcityrecords.com/wnng/",
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "utc_offset" => -18000,
            "id" => 29516238,
            "profile_use_background_image" => true,
            "listed_count" => 118,
            "profile_text_color" => "333333",
            "lang" => "en",
            "followers_count" => 2052,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "profile_background_color" => "9AE4E8",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "You will come to Durham, North Carolina. I will sell you some records then, here in Durham, North Carolina. Fun will happen.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "statuses_count" => 7579,
            "friends_count" => 348,
            "following" => nil,
            "show_all_inline_media" => true,
            "screen_name" => "#{EnvironmentService.twitter_users.first}"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
        ################################################################
        {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Wed Sep 18 23:30:20 +0000 2012",
          "id_str" => "249289491129438208",
          "entities" => {
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "NAAwayDay",
                "indices" => [
                  29,
                  43
                ]
              }
            ],
            "user_mentions" => [
            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "TWITTER USER TWEETS",
          "metadata" => {
            "iso_language_code" => "en",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249289491129438208,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "99CC33",
            "profile_sidebar_border_color" => "829D5E",
            "profile_background_tile" => false,
            "name" => "Thomas John Wakeman",
            "profile_image_url" => "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
            "created_at" => "Tue Sep 01 21:21:35 +0000 2009",
            "location" => "Kingston New York",
            "follow_request_sent" => nil,
            "profile_link_color" => "D02B55",
            "is_translator" => false,
            "id_str" => "70789458",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "",
                    "indices" => [
                      0,
                      0
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [
                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 19,
            "url" => nil,
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
            "utc_offset" => -18000,
            "id" => 70789458,
            "profile_use_background_image" => true,
            "listed_count" => 1,
            "profile_text_color" => "3E4415",
            "lang" => "en",
            "followers_count" => 63,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/images/themes/theme5/bg.gif",
            "profile_background_color" => "352726",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "Science Fiction Writer, sort of. Likes Superheroes, Mole People, Alt. Timelines.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/images/themes/theme5/bg.gif",
            "statuses_count" => 1048,
            "friends_count" => 63,
            "following" => nil,
            "show_all_inline_media" => false,
            "screen_name" => "#{EnvironmentService.twitter_users.first}"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
      ],
      "search_metadata" => {
        "max_id" => 250126199840518145,
        "since_id" => 24012619984051000,
        "refresh_url" => "?since_id=250126199840518145&q=%23NAAwayDay&result_type=mixed&include_entities=1",
        "next_results" => "?max_id=249279667666817023&q=%23NAAwayDay&count=4&include_entities=1&result_type=mixed",
        "count" => 4,
        "completed_in" => 0.035,
        "since_id_str" => "24012619984051000",
        "query" => "%23NAAwayDay",
        "max_id_str" => "250126199840518145"
      }
  ############
    }
  end

  def self.second_tweet_response
    @@second_tweet_response = {
      "statuses" => [
                {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Fri Sep 21 23:50:54 +0000 2012",
          "id_str" => "249292149810667520",
          "entities" => {
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "#{EnvironmentService.hashtag_array.first}",
                "indices" => [
                  20,
                  34
                ]
              }
            ],
            "user_mentions" => [

            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "DAT ISH CRAY AIN'T IT ##{EnvironmentService.hashtag_array.first}",
          "metadata" => {
            "iso_language_code" => "pl",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249292149810667520,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "DDFFCC",
            "profile_sidebar_border_color" => "BDDCAD",
            "profile_background_tile" => true,
            "name" => "Chaz Martenstein",
            "profile_image_url" => "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "created_at" => "Tue Apr 07 19:05:07 +0000 2009",
            "location" => "Durham, NC",
            "follow_request_sent" => nil,
            "profile_link_color" => "0084B4",
            "is_translator" => false,
            "id_str" => "29516238",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "http://bullcityrecords.com/wnng/",
                    "indices" => [
                      0,
                      32
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [

                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 8,
            "url" => "http://bullcityrecords.com/wnng/",
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "utc_offset" => -18000,
            "id" => 29516238,
            "profile_use_background_image" => true,
            "listed_count" => 118,
            "profile_text_color" => "333333",
            "lang" => "en",
            "followers_count" => 2052,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "profile_background_color" => "9AE4E8",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "You will come to Durham, North Carolina. I will sell you some records then, here in Durham, North Carolina. Fun will happen.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "statuses_count" => 7579,
            "friends_count" => 348,
            "following" => nil,
            "show_all_inline_media" => true,
            "screen_name" => "bullcity"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
        ################################################################
        {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Fri Sep 21 23:40:54 +0000 2012",
          "id_str" => "249292149810667520",
          "entities" => {
            "media" => [{
              "id"=>471376386016686080,
              "id_str"=>"471376386016686080",
              "indices"=>[71, 93],
              "media_url"=>"http://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
              "media_url_https"=>"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
              "url"=>"http://t.co/8EO3BWutLc",
              "display_url"=>"pic.twitter.com/8EO3BWutLc",
              "expanded_url"=>"http://twitter.com/scumbling/status/471376390852317184/photo/1",
              "type"=>"photo",
              "sizes"=>{
                "medium"=>{"w"=>600, "h"=>600, "resize"=>"fit"},
                "thumb"=>{"w"=>150, "h"=>150, "resize"=>"crop"},
                "large"=>{"w"=>960, "h"=>960, "resize"=>"fit"},
                "small"=>{"w"=>340, "h"=>340, "resize"=>"fit"}
                }
            }],
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "#{EnvironmentService.hashtag_array.first}",
                "indices" => [
                  20,
                  34
                ]
              }
            ],
            "user_mentions" => [

            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "Thee Namaste Nerdz. ##{EnvironmentService.hashtag_array.first}",
          "metadata" => {
            "iso_language_code" => "pl",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249292149810667520,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "DDFFCC",
            "profile_sidebar_border_color" => "BDDCAD",
            "profile_background_tile" => true,
            "name" => "Chaz Martenstein",
            "profile_image_url" => "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "created_at" => "Tue Apr 07 19:05:07 +0000 2009",
            "location" => "Durham, NC",
            "follow_request_sent" => nil,
            "profile_link_color" => "0084B4",
            "is_translator" => false,
            "id_str" => "29516238",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "http://bullcityrecords.com/wnng/",
                    "indices" => [
                      0,
                      32
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [

                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 8,
            "url" => "http://bullcityrecords.com/wnng/",
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
            "utc_offset" => -18000,
            "id" => 29516238,
            "profile_use_background_image" => true,
            "listed_count" => 118,
            "profile_text_color" => "333333",
            "lang" => "en",
            "followers_count" => 2052,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "profile_background_color" => "9AE4E8",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "You will come to Durham, North Carolina. I will sell you some records then, here in Durham, North Carolina. Fun will happen.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/profile_background_images/9423277/background_tile.bmp",
            "statuses_count" => 7579,
            "friends_count" => 348,
            "following" => nil,
            "show_all_inline_media" => true,
            "screen_name" => "bullcityrecords"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
        ################################################################
        {
          "coordinates" => nil,
          "favorited" => false,
          "truncated" => false,
          "created_at" => "Fri Sep 21 23:30:20 +0000 2012",
          "id_str" => "249289491129438208",
          "entities" => {
            "urls" => [

            ],
            "hashtags" => [
              {
                "text" => "#{EnvironmentService.hashtag_array.first}",
                "indices" => [
                  29,
                  43
                ]
              }
            ],
            "user_mentions" => [
            ]
          },
          "in_reply_to_user_id_str" => nil,
          "contributors" => nil,
          "text" => "Mexican Heaven, Mexican Hell ##{EnvironmentService.hashtag_array.first}",
          "metadata" => {
            "iso_language_code" => "en",
            "result_type" => "recent"
          },
          "retweet_count" => 0,
          "in_reply_to_status_id_str" => nil,
          "id" => 249289491129438208,
          "geo" => nil,
          "retweeted" => false,
          "in_reply_to_user_id" => nil,
          "place" => nil,
          "user" => {
            "profile_sidebar_fill_color" => "99CC33",
            "profile_sidebar_border_color" => "829D5E",
            "profile_background_tile" => false,
            "name" => "Thomas John Wakeman",
            "profile_image_url" => "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
            "created_at" => "Tue Sep 01 21:21:35 +0000 2009",
            "location" => "Kingston New York",
            "follow_request_sent" => nil,
            "profile_link_color" => "D02B55",
            "is_translator" => false,
            "id_str" => "70789458",
            "entities" => {
              "url" => {
                "urls" => [
                  {
                    "expanded_url" => nil,
                    "url" => "",
                    "indices" => [
                      0,
                      0
                    ]
                  }
                ]
              },
              "description" => {
                "urls" => [
                ]
              }
            },
            "default_profile" => false,
            "contributors_enabled" => false,
            "favourites_count" => 19,
            "url" => nil,
            "profile_image_url_https" => "https://si0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
            "utc_offset" => -18000,
            "id" => 70789458,
            "profile_use_background_image" => true,
            "listed_count" => 1,
            "profile_text_color" => "3E4415",
            "lang" => "en",
            "followers_count" => 63,
            "protected" => false,
            "notifications" => nil,
            "profile_background_image_url_https" => "https://si0.twimg.com/images/themes/theme5/bg.gif",
            "profile_background_color" => "352726",
            "verified" => false,
            "geo_enabled" => false,
            "time_zone" => "Eastern Time (US & Canada)",
            "description" => "Science Fiction Writer, sort of. Likes Superheroes, Mole People, Alt. Timelines.",
            "default_profile_image" => false,
            "profile_background_image_url" => "http://a0.twimg.com/images/themes/theme5/bg.gif",
            "statuses_count" => 1048,
            "friends_count" => 63,
            "following" => nil,
            "show_all_inline_media" => false,
            "screen_name" => "MonkiesFist"
          },
          "in_reply_to_screen_name" => nil,
          "source" => "web",
          "in_reply_to_status_id" => nil
        },
      ],
      "search_metadata" => {
        "max_id" => 250126199840518145,
        "since_id" => 24012619984051000,
        "refresh_url" => "?since_id=250126199840518145&q=%23#{EnvironmentService.hashtag_array.first}&result_type=mixed&include_entities=1",
        "next_results" => "?max_id=249279667666817023&q=%23#{EnvironmentService.hashtag_array.first}&count=4&include_entities=1&result_type=mixed",
        "count" => 4,
        "completed_in" => 0.035,
        "since_id_str" => "24012619984051000",
        "query" => "%23#{EnvironmentService.hashtag_array.first}",
        "max_id_str" => "250126199840518145"
      }
    }
  end

  def self.tweet_response
    @@tweet_response = {
        "statuses" => [
          {
            "coordinates" => nil,
            "favorited" => false,
            "truncated" => false,
            "created_at" => "Fri Sep 21 23:40:54 +0000 2012",
            "id_str" => "249292149810667520",
            "entities" => {
              "media" => [{
                "id"=>471376386016686080,
                "id_str"=>"471376386016686080",
                "indices"=>[71, 93],
                "media_url"=>"http://media-cache-ak0.pinimg.com/736x/cf/69/d9/cf69d915e40a62409133e533b64186f1.jpg",
                "media_url_https"=>"http://media-cache-ak0.pinimg.com/736x/cf/69/d9/cf69d915e40a62409133e533b64186f1.jpg",
                "url"=>"http://t.co/8EO3BWutLc",
                "display_url"=>"pic.twitter.com/8EO3BWutLc",
                "expanded_url"=>"http://twitter.com/scumbling/status/471376390852317184/photo/1",
                "type"=>"photo",
                "sizes"=>{
                  "medium"=>{"w"=>600, "h"=>600, "resize"=>"fit"},
                  "thumb"=>{"w"=>150, "h"=>150, "resize"=>"crop"},
                  "large"=>{"w"=>960, "h"=>960, "resize"=>"fit"},
                  "small"=>{"w"=>340, "h"=>340, "resize"=>"fit"}
                  }
              }],
              "urls" => [

              ],
              "hashtags" => [
                {
                  "text" => "#{EnvironmentService.hashtag_array.first}",
                  "indices" => [
                    20,
                    34
                  ]
                }
              ],
              "user_mentions" => [

              ]
            },
            "in_reply_to_user_id_str" => nil,
            "contributors" => nil,
            "text" => "Thee Namaste Nerdz. ##{EnvironmentService.hashtag_array.first}",
            "metadata" => {
              "iso_language_code" => "pl",
              "result_type" => "recent"
            },
            "retweet_count" => 0,
            "in_reply_to_status_id_str" => nil,
            "id" => 249292149810667520,
            "geo" => nil,
            "retweeted" => false,
            "in_reply_to_user_id" => nil,
            "place" => nil,
            "user" => {
              "profile_sidebar_fill_color" => "DDFFCC",
              "profile_sidebar_border_color" => "BDDCAD",
              "profile_background_tile" => true,
              "name" => "Chaz Martenstein",
              "profile_image_url" => "http://upload.wikimedia.org/wikipedia/commons/b/bf/Pembroke_Welsh_Corgi_600.jpg",
              "created_at" => "Tue Apr 07 19:05:07 +0000 2009",
              "location" => "Durham, NC",
              "follow_request_sent" => nil,
              "profile_link_color" => "0084B4",
              "is_translator" => false,
              "id_str" => "29516238",
              "entities" => {
                "url" => {
                  "urls" => [
                    {
                      "expanded_url" => nil,
                      "url" => "http://bullcityrecords.com/wnng/",
                      "indices" => [
                        0,
                        32
                      ]
                    }
                  ]
                },
                "description" => {
                  "urls" => [

                  ]
                }
              },
              "default_profile" => false,
              "contributors_enabled" => false,
              "favourites_count" => 8,
              "url" => "http://bullcityrecords.com/wnng/",
              "profile_image_url_https" => "https://si0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
              "utc_offset" => -18000,
              "id" => 29516238,
              "profile_use_background_image" => true,
              "listed_count" => 118,
              "profile_text_color" => "333333",
              "lang" => "en",
              "followers_count" => 2052,
              "protected" => false,
              "notifications" => nil,
              "profile_background_image_url_https" => "https://si0.twimg.com/profile_background_images/9423277/background_tile.bmp",
              "profile_background_color" => "9AE4E8",
              "verified" => false,
              "geo_enabled" => false,
              "time_zone" => "Eastern Time (US & Canada)",
              "description" => "You will come to Durham, North Carolina. I will sell you some records then, here in Durham, North Carolina. Fun will happen.",
              "default_profile_image" => false,
              "profile_background_image_url" => "http://a0.twimg.com/profile_background_images/9423277/background_tile.bmp",
              "statuses_count" => 7579,
              "friends_count" => 348,
              "following" => nil,
              "show_all_inline_media" => true,
              "screen_name" => "bullcityrecords"
            },
            "in_reply_to_screen_name" => nil,
            "source" => "web",
            "in_reply_to_status_id" => nil
          },
          ################################################################
          {
            "coordinates" => nil,
            "favorited" => false,
            "truncated" => false,
            "created_at" => "Fri Sep 21 23:30:20 +0000 2012",
            "id_str" => "249289491129438208",
            "entities" => {
              "urls" => [

              ],
              "hashtags" => [
                {
                  "text" => "#{EnvironmentService.hashtag_array.first}",
                  "indices" => [
                    29,
                    43
                  ]
                }
              ],
              "user_mentions" => [
              ]
            },
            "in_reply_to_user_id_str" => nil,
            "contributors" => nil,
            "text" => "Mexican Heaven, Mexican Hell ##{EnvironmentService.hashtag_array.first}",
            "metadata" => {
              "iso_language_code" => "en",
              "result_type" => "recent"
            },
            "retweet_count" => 0,
            "in_reply_to_status_id_str" => nil,
            "id" => 249289491129438208,
            "geo" => nil,
            "retweeted" => false,
            "in_reply_to_user_id" => nil,
            "place" => nil,
            "user" => {
              "profile_sidebar_fill_color" => "99CC33",
              "profile_sidebar_border_color" => "829D5E",
              "profile_background_tile" => false,
              "name" => "Thomas John Wakeman",
              "profile_image_url" => "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
              "created_at" => "Tue Sep 01 21:21:35 +0000 2009",
              "location" => "Kingston New York",
              "follow_request_sent" => nil,
              "profile_link_color" => "D02B55",
              "is_translator" => false,
              "id_str" => "70789458",
              "entities" => {
                "url" => {
                  "urls" => [
                    {
                      "expanded_url" => nil,
                      "url" => "",
                      "indices" => [
                        0,
                        0
                      ]
                    }
                  ]
                },
                "description" => {
                  "urls" => [
                  ]
                }
              },
              "default_profile" => false,
              "contributors_enabled" => false,
              "favourites_count" => 19,
              "url" => nil,
              "profile_image_url_https" => "https://si0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
              "utc_offset" => -18000,
              "id" => 70789458,
              "profile_use_background_image" => true,
              "listed_count" => 1,
              "profile_text_color" => "3E4415",
              "lang" => "en",
              "followers_count" => 63,
              "protected" => false,
              "notifications" => nil,
              "profile_background_image_url_https" => "https://si0.twimg.com/images/themes/theme5/bg.gif",
              "profile_background_color" => "352726",
              "verified" => false,
              "geo_enabled" => false,
              "time_zone" => "Eastern Time (US & Canada)",
              "description" => "Science Fiction Writer, sort of. Likes Superheroes, Mole People, Alt. Timelines.",
              "default_profile_image" => false,
              "profile_background_image_url" => "http://a0.twimg.com/images/themes/theme5/bg.gif",
              "statuses_count" => 1048,
              "friends_count" => 63,
              "following" => nil,
              "show_all_inline_media" => false,
              "screen_name" => "MonkiesFist"
            },
            "in_reply_to_screen_name" => nil,
            "source" => "web",
            "in_reply_to_status_id" => nil
          },
        ],
        "search_metadata" => {
          "max_id" => 250126199840518145,
          "since_id" => 24012619984051000,
          "refresh_url" => "?since_id=250126199840518145&q=%23#{EnvironmentService.hashtag_array.first}&result_type=mixed&include_entities=1",
          "next_results" => "?max_id=249279667666817023&q=%23#{EnvironmentService.hashtag_array.first}&count=4&include_entities=1&result_type=mixed",
          "count" => 4,
          "completed_in" => 0.035,
          "since_id_str" => "24012619984051000",
          "query" => "%23#{EnvironmentService.hashtag_array.first}",
          "max_id_str" => "250126199840518145"
        }
      }
  end

  def self.tweets_from_censored_users
    @@tweets_from_censored_users = {
        "statuses" => [
          {
            "coordinates" => nil,
            "favorited" => false,
            "truncated" => false,
            "created_at" => "Fri Sep 21 23:40:54 +0000 2012",
            "id_str" => "249292149810667520",
            "entities" => {
              "media" => [{
                "id"=>471376386016686080,
                "id_str"=>"471376386016686080",
                "indices"=>[71, 93],
                "media_url"=>"http://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
                "media_url_https"=>"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg",
                "url"=>"http://t.co/8EO3BWutLc",
                "display_url"=>"pic.twitter.com/8EO3BWutLc",
                "expanded_url"=>"http://twitter.com/scumbling/status/471376390852317184/photo/1",
                "type"=>"photo",
                "sizes"=>{
                  "medium"=>{"w"=>600, "h"=>600, "resize"=>"fit"},
                  "thumb"=>{"w"=>150, "h"=>150, "resize"=>"crop"},
                  "large"=>{"w"=>960, "h"=>960, "resize"=>"fit"},
                  "small"=>{"w"=>340, "h"=>340, "resize"=>"fit"}
                  }
              }],
              "urls" => [

              ],
              "hashtags" => [
                {
                  "text" => "#{EnvironmentService.hashtag_array.first}",
                  "indices" => [
                    20,
                    34
                  ]
                }
              ],
              "user_mentions" => [

              ]
            },
            "in_reply_to_user_id_str" => nil,
            "contributors" => nil,
            "text" => "Thee Namaste Nerdz. ##{EnvironmentService.hashtag_array.first}",
            "metadata" => {
              "iso_language_code" => "pl",
              "result_type" => "recent"
            },
            "retweet_count" => 0,
            "in_reply_to_status_id_str" => nil,
            "id" => 249292149810667520,
            "geo" => nil,
            "retweeted" => false,
            "in_reply_to_user_id" => nil,
            "place" => nil,
            "user" => {
              "profile_sidebar_fill_color" => "DDFFCC",
              "profile_sidebar_border_color" => "BDDCAD",
              "profile_background_tile" => true,
              "name" => "Chaz Martenstein",
              "profile_image_url" => "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
              "created_at" => "Tue Apr 07 19:05:07 +0000 2009",
              "location" => "Durham, NC",
              "follow_request_sent" => nil,
              "profile_link_color" => "0084B4",
              "is_translator" => false,
              "id_str" => "29516238",
              "entities" => {
                "url" => {
                  "urls" => [
                    {
                      "expanded_url" => nil,
                      "url" => "http://bullcityrecords.com/wnng/",
                      "indices" => [
                        0,
                        32
                      ]
                    }
                  ]
                },
                "description" => {
                  "urls" => [

                  ]
                }
              },
              "default_profile" => false,
              "contributors_enabled" => false,
              "favourites_count" => 8,
              "url" => "http://bullcityrecords.com/wnng/",
              "profile_image_url_https" => "https://si0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
              "utc_offset" => -18000,
              "id" => 29516238,
              "profile_use_background_image" => true,
              "listed_count" => 118,
              "profile_text_color" => "333333",
              "lang" => "en",
              "followers_count" => 2052,
              "protected" => false,
              "notifications" => nil,
              "profile_background_image_url_https" => "https://si0.twimg.com/profile_background_images/9423277/background_tile.bmp",
              "profile_background_color" => "9AE4E8",
              "verified" => false,
              "geo_enabled" => false,
              "time_zone" => "Eastern Time (US & Canada)",
              "description" => "You will come to Durham, North Carolina. I will sell you some records then, here in Durham, North Carolina. Fun will happen.",
              "default_profile_image" => false,
              "profile_background_image_url" => "http://a0.twimg.com/profile_background_images/9423277/background_tile.bmp",
              "statuses_count" => 7579,
              "friends_count" => 348,
              "following" => nil,
              "show_all_inline_media" => true,
              "screen_name" => ENV["CENSORED_USERS"].split("|").sample()
            },
            "in_reply_to_screen_name" => nil,
            "source" => "web",
            "in_reply_to_status_id" => nil
          },
          ################################################################
          {
            "coordinates" => nil,
            "favorited" => false,
            "truncated" => false,
            "created_at" => "Fri Sep 21 23:30:20 +0000 2012",
            "id_str" => "249289491129438208",
            "entities" => {
              "urls" => [

              ],
              "hashtags" => [
                {
                  "text" => "#{EnvironmentService.hashtag_array.first}",
                  "indices" => [
                    29,
                    43
                  ]
                }
              ],
              "user_mentions" => [
              ]
            },
            "in_reply_to_user_id_str" => nil,
            "contributors" => nil,
            "text" => "Mexican Heaven, Mexican Hell ##{EnvironmentService.hashtag_array.first}",
            "metadata" => {
              "iso_language_code" => "en",
              "result_type" => "recent"
            },
            "retweet_count" => 0,
            "in_reply_to_status_id_str" => nil,
            "id" => 249289491129438208,
            "geo" => nil,
            "retweeted" => false,
            "in_reply_to_user_id" => nil,
            "place" => nil,
            "user" => {
              "profile_sidebar_fill_color" => "99CC33",
              "profile_sidebar_border_color" => "829D5E",
              "profile_background_tile" => false,
              "name" => "Thomas John Wakeman",
              "profile_image_url" => "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
              "created_at" => "Tue Sep 01 21:21:35 +0000 2009",
              "location" => "Kingston New York",
              "follow_request_sent" => nil,
              "profile_link_color" => "D02B55",
              "is_translator" => false,
              "id_str" => "70789458",
              "entities" => {
                "url" => {
                  "urls" => [
                    {
                      "expanded_url" => nil,
                      "url" => "",
                      "indices" => [
                        0,
                        0
                      ]
                    }
                  ]
                },
                "description" => {
                  "urls" => [
                  ]
                }
              },
              "default_profile" => false,
              "contributors_enabled" => false,
              "favourites_count" => 19,
              "url" => nil,
              "profile_image_url_https" => "https://si0.twimg.com/profile_images/2219333930/Froggystyle_normal.png",
              "utc_offset" => -18000,
              "id" => 70789458,
              "profile_use_background_image" => true,
              "listed_count" => 1,
              "profile_text_color" => "3E4415",
              "lang" => "en",
              "followers_count" => 63,
              "protected" => false,
              "notifications" => nil,
              "profile_background_image_url_https" => "https://si0.twimg.com/images/themes/theme5/bg.gif",
              "profile_background_color" => "352726",
              "verified" => false,
              "geo_enabled" => false,
              "time_zone" => "Eastern Time (US & Canada)",
              "description" => "Science Fiction Writer, sort of. Likes Superheroes, Mole People, Alt. Timelines.",
              "default_profile_image" => false,
              "profile_background_image_url" => "http://a0.twimg.com/images/themes/theme5/bg.gif",
              "statuses_count" => 1048,
              "friends_count" => 63,
              "following" => nil,
              "show_all_inline_media" => false,
              "screen_name" => ENV["CENSORED_USERS"].split("|").sample()
            },
            "in_reply_to_screen_name" => nil,
            "source" => "web",
            "in_reply_to_status_id" => nil
          },
        ],
        "search_metadata" => {
          "max_id" => 250126199840518145,
          "since_id" => 24012619984051000,
          "refresh_url" => "?since_id=250126199840518145&q=%23#{EnvironmentService.hashtag_array.first}&result_type=mixed&include_entities=1",
          "next_results" => "?max_id=249279667666817023&q=%23#{EnvironmentService.hashtag_array.first}&count=4&include_entities=1&result_type=mixed",
          "count" => 4,
          "completed_in" => 0.035,
          "since_id_str" => "24012619984051000",
          "query" => "%23#{EnvironmentService.hashtag_array.first}",
          "max_id_str" => "250126199840518145"
        }
      }
  end
end
