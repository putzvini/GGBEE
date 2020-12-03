class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @top_audience_avg = top_avg_chart(:match_view)
    @top_likes_avg = top_avg_chart(:match_like)
    @top_comment_avg = top_comment_avg(:match_comment)
  end

  def show
    @teams = Team.all
    @team = Team.find(params[:id])
    @banner = banner_infos(params[:id])
    # @audience_split = audience_split(params[:id])
    @last_5 = last_5(:match_view, params[:id])
    # @top_5 =  
  end

end

def last_5(data, id)
  response = {}
  Match.where(red_team_id: id).or(Match.where(blue_team_id: id)).sort_by{|match| match[:match_date]}.last(5).each do |match|
    date = match[:match_date].to_formatted_s(:rfc822)
    response[date] = match[:match_view]
  end
  response
end