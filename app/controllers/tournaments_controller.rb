class TournamentsController < ApplicationController
  def index
    response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=tGsGeGnV43o&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics&maxResults=100")
    video = JSON.parse(response.body)
    
    # cast_url: video["items"].first["id"]
    # year = video["items"].first["snippet"]["publishedAt"][0..3].to_i
    # month = video["items"].first["snippet"]["publishedAt"][5..6].to_i
    # day = video["items"].first["snippet"]["publishedAt"][8..9].to_i
    # cast_date = Date.new(year, month, day)
    # cast_time: ?????
    # cast_view: video["items"].first["statistics"]["viewCount"]
    # cast_like: video["items"].first["statistics"]["likeCount"]
    # cast_dislike: video["items"].first["statistics"]["dislikeCount"]
    # cast_comment: video["items"].first["statistics"]["commentCount"]
    # round_id: Round.where(round_date: :cast_date).id

    
     duration = video["items"].first["contentDetails"]['duration']
     
     @test = ISO8601::Duration.new(duration)


  end
end
