class TeamsController < ApplicationController

    @top_audience_avg = top_avg_chart(:match_view)
    @top_likes_avg = top_avg_chart(:match_like)
    @top_comment_avg = top_avg_chart(:match_comment)

  end

  def show
    @teams = Team.all
    @team = Team.find(params[:id])
    @banner = banner_infos(params[:id])
    @last_5 = last_5(params[:id])
    @top_5 = top_5(params[:id])
  end
end
