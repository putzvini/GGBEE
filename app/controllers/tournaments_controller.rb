class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
    @audience = audience
    @banner_infos = banner_infos_tournaments
    @donut = avg_time

   # @line_chart_data = Audience.all.map { |datas|
    #{name: datas.views_cast, data: datas.gspeeds.group_by_minute(:created_at).average(:speed)}
    #}
    @data = []
    @top_harray = []
    @top_5_tournament = Tournament.first(5)
    @top_5_tournament.each do  |tournament|
    @top_harray << tournament.top_chart_casts(tournament.id)
    end

    @top_harray.each do |tournament|
      tournament.each do |info|
      @data.push([info[0], info[1]])
      end
    end
  end

  def show
    @banner = banner_infos_split(params[:id])
    @top_5_casts = top_5_casts(params[:id])
    @top_5_matches = top_5_matches(params[:id])
    @round_views = round_views(params[:id])
  end
end
