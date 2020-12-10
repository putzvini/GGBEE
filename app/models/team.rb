class Team < ApplicationRecord
  has_many :players
  validates :team_name, :team_long_name, :team_tag, presence: true
end

def top_teams
  teams_array = []
  Team.all.each do |team|
    arg = Match.select(:match_view).where(red_team_id: team.id).or(Match.select(:match_view).where(blue_team_id: team.id))
    views = []
    arg.each do |match|
      views << match[:match_view]
    end
    matches = views.count
    avg_views = (views.sum / matches).round
    args2 = Match.select(:match_like).where(red_team_id: team.id).or(Match.select(:match_like).where(blue_team_id: team.id))
    likes = []
    args2.each do |match|
      likes << match[:match_like]
    end
    avg_likes = (likes.sum / matches)
    hash = {}
    hash = {
      team_id: team.id,
      team_tag: team.team_tag,
      team: team.team_name,
      matches: matches,
      avg_views: avg_views,
      avg_likes: avg_likes
    }
    teams_array << hash
  end
  response = teams_array.sort_by { |hsh| hsh[:avg_views]}.last(3).reverse
end

def top_avg_chart(data)
  response = {}
  Team.all.each do |team|
    response[team.team_name.titleize] = 0
    b = Match.select(data).where(blue_team_id: team.id)
    b_count = b.count
    b_sum = 0
    b.each do |relation|
      b_sum += relation[data]
    end
    r = Match.select(data).where(red_team_id: team.id)
    r_count = r.count
    r_sum = 0
    r.each do |relation|
      r_sum += relation[data]
    end
    response[team.team_name.titleize] += ((b_sum + r_sum)/(b_count + r_count)).round
  end
  response.sort_by { |k, v| v }.reverse
end

def banner_infos_team(id)
  response = {}
  team = Team.find(id)

  matches = Match.where(red_team_id: id).or(Match.where(blue_team_id: id)).count

  response[:matches] = matches
  response[:views] = calc_x(:match_view, id)
  response[:views_match] = (response[:views] / matches).round
  response[:likes] = calc_x(:match_like, id)
  response[:comments] = calc_x(:match_comment, id)
  response[:dislikes] = calc_x(:match_dislike, id)
  response
end

def last_5_matches(id)
  response = []
  var = Match.where(red_team_id: id).or(Match.where(blue_team_id: id)).sort_by{|match| match.match_date}.last(5)
  var.each_with_index do |match, i|
    array = []
    array << "##{5-i} | #{match.match_date.to_formatted_s(:rfc822)}"
    array << match.match_view
    response << array
  end
  response
end

def top_5_matches(id)
  response = []
  var = Match.where(red_team_id: id).or(Match.where(blue_team_id: id)).sort_by{|match| match.match_view}.last(5)

  var.each do |match|
    cast = Cast.find(match.cast_id)
    round = Round.find(cast.round_id)
    tournament = Tournament.find(round.tournament_id)
    response << {
      tournament: "CBLOL #{tournament.season} - Split #{tournament.split}",
      team_blue: Team.find(match.blue_team_id),
      team_red: Team.find(match.red_team_id),
      views: match.match_view,
      date: match.match_date.to_formatted_s(:rfc822)
    }
  end
  response = response.sort_by { |e| e[:views] }.reverse
end

def players(id)
  response = Player.where(team_id: id)
end

private

def calc_x(data, id)
  sum = 0
  arg = Match.select(data).where(red_team_id: id).or(Match.select(data).where(blue_team_id: id))
  arg.each do |a|
    sum += a[data]
  end
  sum
end
