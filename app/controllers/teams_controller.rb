class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @top_teams = top_teams
    @top_audience_avg = top_avg_chart(:match_view)
    @top_likes_avg = top_avg_chart(:match_like)
    @top_comment_avg = top_avg_chart(:match_comment)
    
  end

  def show
    @teams = Team.all
    @team = Team.find(params[:id])
    @banner = banner_infos_team(params[:id])
    @last_5_matches = last_5(params[:id])
    @top_5_matches = top_5(params[:id])
    @players = players(params[:id])
  end
end
