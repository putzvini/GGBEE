class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
    @teams = Team.all
    @past_splits = past_splits_table
    @audience = audience
    @banner_infos = banner_infos_tournaments
    @avg_time = avg_time
    @donut = donut
    
  end

  def show
    @tournaments = Tournament.all
    @tournament = Tournament.find(params[:id])
    @banner = banner_infos_split(params[:id])
    @top_5_casts = top_5_casts(params[:id])
    @top_5_matches = top_5_matches(params[:id])
    @round_views = round_views(params[:id])
  end
end