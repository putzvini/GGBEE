class Tournament < ApplicationRecord
  has_many :rounds
  validates :season, :split, presence: true
  
end

def audience
  response = {}
  Round.all.each do |r|
    round = r.round_date.to_formatted_s(:rfc822)
    response[round] = Cast.find(r.id).cast_view
  end
  response
end

def past_splits_table
  response = []
  champion = ['itz', 'fla', 'kbm', 'itz' ]
  Tournament.all.each_with_index do |t, i|
    hash = {}
    hash[:tournament] = "#{t.season} - Split #{t.split}"
    hash[:start_date] = Round.where(tournament_id: t.id).first[:round_date].to_formatted_s(:rfc822)
    hash[:end_date] = Round.where(tournament_id: t.id).last[:round_date].to_formatted_s(:rfc822)
    hash[:rounds] = Round.where(tournament_id: t.id).count
    hash[:champion] = Team.where(team_tag: champion[i]).first.team_name.capitalize
    hash[:t_id] = t.id
    response << hash
  end
  response
end

def banner_infos_tournaments
  response = {}
  casts = Cast.all.count
  views = sum_x(:cast_view)
  
  response[:casts] = casts
  response[:views] = views
  response[:views_cast] = (views / casts).round
  response[:likes] = sum_x(:cast_like)
  response[:comments] = sum_x(:cast_comment)
  response[:dislikes] = sum_x(:cast_dislike)
  response
end

def avg_time
  response = {}
  avg_time_sec = (Cast.all.sum(:cast_time) / Cast.all.count)
  response[:avg_time] = Time.at(avg_time_sec).utc.strftime("%H:%M:%S")
  response
end

def donut
  response = {}
  avg_time_sec = (Cast.all.sum(:cast_time) / Cast.all.count)
  wait_time_sec = 3780
  match_time_sec = (Match.all.sum(:match_time) / Match.all.count)*4
  others_time_sec = avg_time_sec - wait_time_sec - match_time_sec

  response[:wait_time] = wait_time_sec/60
  response[:in_match] = match_time_sec/60
  response[:others] = others_time_sec/60

  response
end

private

def sum_x(data)
  sum = Cast.all.sum(data)
end

def banner_infos_split(id)
  response = {}
  
  casts = Round.where(tournament_id: id).count
  time = 0
  matches = 0
  views = 0
  likes = 0

  Round.where(tournament_id: id).each do |r|
    c = Cast.find(r.id)
      time += c.cast_time
      matches += Match.where(cast_id: c.id).count
      views += c.cast_view
      likes += c.cast_like
  end
  
  response[:casts] = casts
  response[:time] = time / 60
  response[:matches] = matches
  response[:views] = views
  response[:views_cast] = views / casts
  response[:likes_cast] = likes / casts
  response
end

def top_5_casts(id)
  response = {}
  hash = round_views(id)
  hash.sort_by { |k, v| v }.last(5).reverse.each do |m|
    response[m[0]] = m[1]
  end
  response
end

def top_5_matches(id)
  array = []
  Round.where(tournament_id: id).each do |r|
    Match.where(cast_id: r.id).each do |m|
      date = m.match_date.to_formatted_s(:rfc822)
      hash = {}
      hash[:date] = date
      hash[:views] = m.match_view 
      hash[:team_blue] = Team.find(m.blue_team_id)
      hash[:team_red] = Team.find(m.red_team_id)
      array << hash
    end
  end
  response = array.sort_by { |match| match[:views] }.last(5).reverse
  response
end

def round_views(id)
  response = {}
  Round.where(tournament_id: id).each do |r|
    c = Cast.find(r.id)
    date = c.cast_date.to_formatted_s(:rfc822)
    response[date] = c.cast_view
  end
  response
end