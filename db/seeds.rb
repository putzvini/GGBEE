# libraries 
require 'json'
require 'open-uri'
require 'nokogiri'

# seed for tournaments table
puts 'Creating tournaments'

cblol_2019_1 = Tournament.create!(season: 2019,
                                  split: 1
)

cblol_2019_2 = Tournament.create!(season: 2019,
                                  split: 2
)
                                  
cblol_2020_1 = Tournament.create!(season: 2020,
                                  split: 1
)
                                  
cblol_2020_2 = Tournament.create!(season: 2020,
                                  split: 2
)

# seed for teams table
puts "Creating teams"

# team array = name, longa_name, tag and photo path
cnb = ["cnb", "cnb e-sports", "cnb"]
flamengo = ["flamengo", "flamengo e-sports", "fla"]
intz = ["intz", "intz", "itz"]                   
kabum = ["kabum", "kabum e-sports", "kbm"]
keyd = ["keyd", "vivo keyd", "vk",]
pain = ["pain", "pain gaming", "png"]
redemption = ["redemption", "redemption e-sports", "rdp"]
team_one = ["team one" , "team one e-sports", "one",]
uppercut = ["uppercut", "uppercut e-sports", "up"]
furia = ["furia", "furia e-sports", "fur"]
prodigy = [ "prodigy", "prodigy e-sports", "prg"]
santos = ["santos", "santos hotforex", "san"]


teams = [ cnb, flamengo, furia, intz, kabum, keyd, pain, prodigy, redemption, santos, team_one, uppercut ]

teams.each do |team|
  Team.create!(team_name: team[0],
              team_long_name: team[1],
              team_tag: team[2],
  )
end

puts "Creatign methods for rounds table seeding"

def seed_point_rounds(dates, stage, tournament)
  dates.each_with_index do |round, i|
    Round.create!(round_stage: stage,
                  round_day: (i + 1).to_s,
                  round_date: Date.new(tournament.season, round[0], round[1]),
                  tournament_id: tournament.id
    )
  end
end

def seed_playoffs_rounds(dates, stage, tournament)
  playoffs = ["semi 1", "semi 2", "sfinal"]
  dates.each_with_index do |round, i|
    Round.create!(round_stage: stage,
                  round_day: playoffs[i],
                  round_date: Date.new(tournament.season, round[0], round[1]),
                  tournament_id: tournament.id
    )
  end
end

# seed rounds table - variables creation
puts "Creatign variables for rounds table seeding"

points = "pontos"
playoffs = "playoffs"

# seed rounds table for 2019 split 1
puts "Seeding rounds table for 2019 split 1"

s2019_1_dates_points = [
          [1,12],
          [1,13],
          [1,19],
          [1,20],
          [1,26],
          [1,27],
          [2,2],
          [2,3],
          [2,9],
          [2,10],
          [2,16],
          [2,17],
          [2,23],
          [2,24],
          [3,8],
          [3,9],
          [3,10],
          [3,16],
          [3,17],
          [3,23],
          [3,24]
]

s2019_1_dates_playoffs = [ [4,6], [4,7], [4,27] ]

seed_point_rounds(s2019_1_dates_points, points, cblol_2019_1)
seed_playoffs_rounds(s2019_1_dates_playoffs, playoffs, cblol_2019_1)


# exception date in split 1 - 2019
Round.create!(round_stage: points,
              round_day: 9.to_s,
              round_date: Date.new(2019, 2, 11),
              tournament_id: cblol_2019_1.id
)

# promotion series  in split 1 - 2019
Round.create!(round_stage: playoffs,
              round_day: "promoção",
              round_date: Date.new(2019, 4, 13),
              tournament_id: cblol_2019_1.id
) 

# seed rounds table for 2019 split 2
puts "Seeding rounds table for 2019 split 2 - points stage"

s2019_2_dates_points = [
          [6,1],
          [6,2],
          [6,8],
          [6,9],
          [6,15],
          [6,16],
          [6,22],
          [6,23],
          [6,29],
          [6,30],
          [7,6],
          [7,7],
          [7,13],
          [7,14],
          [7,20],
          [7,21],
          [7,27],
          [7,28],
          [8,3],
          [8,4],
          [8,10]
]

s2019_2_dates_playoffs = [ [8,24], [8,25], [9,7] ]

seed_point_rounds(s2019_2_dates_points, points, cblol_2019_2)
seed_playoffs_rounds(s2019_2_dates_playoffs, playoffs, cblol_2019_2)

# promotion series  in split 2 - 2019

Round.create!(round_stage: playoffs,
              round_day: "promoção",
              round_date: Date.new(2019, 9, 21),
              tournament_id: cblol_2019_2.id
) 

# seed rounds table for 2020 split 1
puts "Seeding rounds table for 2020 split 1 - points stage"

s2020_1_dates_points = [
          [1,25],
          [1,26],
          [1,02],
          [2,2],
          [2,8],
          [2,9],
          [2,29],
          [3,1],
          [3,7],
          [3,8],
          [3,14],
          [3,15],
          [4,10],
          [4,11],
          [4,12],
          [4,17],
          [4,18],
          [4,19],
          [4,24],
          [4,25],
          [4,26]
]

s2020_1_dates_playoffs = [ [5,2], [5,3], [5,9] ]

seed_point_rounds(s2020_1_dates_points, points, cblol_2020_1)
seed_playoffs_rounds(s2020_1_dates_playoffs, playoffs, cblol_2020_1)

Round.create!(round_stage: playoffs,
              round_day: "promoção",
              round_date: Date.new(2020, 5, 19),
              tournament_id: cblol_2020_1.id
) 

# seed rounds table for 2020 split 2
puts "Seeding rounds table for 2020 split 2 - points stage"

s2020_2_dates_points = [
          [6,6],
          [6,7],
          [6,13],
          [6,14],
          [6,20],
          [6,21],
          [6,27],
          [6,28],
          [7,4],
          [7,5],
          [7,11],
          [7,12],
          [7,18],
          [7,19],
          [7,25],
          [7,26],
          [8,1],
          [8,2],
          [8,7],
          [8,8],
          [8,9]
]

s2020_2_dates_playoffs = [ [8,22], [8,23], [9,5] ]

seed_point_rounds(s2020_2_dates_points, points, cblol_2020_2)
seed_playoffs_rounds(s2020_2_dates_playoffs, playoffs, cblol_2020_2)

