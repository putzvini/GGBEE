class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
    @audience = audience
    @banner_infos = banner_infos_tournaments
    @donut = avg_time
  end

  def show
    @banner = banner_infos_split(params[:id])
    @top_5_casts = top_5_casts(params[:id])
    @top_5_matches = top_5_matches(params[:id])
    @round_views = round_views(params[:id])
  end
end