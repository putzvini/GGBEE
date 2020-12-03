class Team < ApplicationRecord
  validates :team_name, :team_long_name, :team_tag, presence: true
end

def top_avg_chart(data)
  response = {}
  Team.all.each do |team|
    response[team.team_name.capitalize] = 0
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
    response[team.team_name.capitalize] += ((b_sum + r_sum)/(b_count + r_count)).round
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

def last_5(id)
  response = {}
  var = Match.where(red_team_id: id).or(Match.where(blue_team_id: id)).sort_by{|match| match.match_date}.last(5)

  var.each do |match|
    date = match.match_date.to_formatted_s(:rfc822)
    response[date] = match.match_view
  end
  response
end

def top_5(id)
  response = []
  var = Match.where(red_team_id: id).or(Match.where(blue_team_id: id)).sort_by{|match| match.match_view}.last(5)

  var.each do |match|
    cast = Cast.find(match.cast_id)
    round = Round.find(cast.round_id)
    tournament = Tournament.find(round.tournament_id)
    response << {
      tournament: "CBLOL #{tournament.season} - Split #{tournament.split}",
      team_blue: Team.find(match.blue_team_id).team_name,
      team_red: Team.find(match.red_team_id).team_name,
      views: match.match_like,
      date: match.match_date,
    }
  end
  response.sort_by { |e| e[:views] }.reverse
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
