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

# seed rounds table

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

s2019_1_dates_playoffs = [ [4,6], [4,7], [4,13] ]

seed_point_rounds(s2019_1_dates_points, points, cblol_2019_1)
seed_playoffs_rounds(s2019_1_dates_playoffs, playoffs, cblol_2019_1)


# exception date in split 1 - 2019
# Round.create!(round_stage: points,
#               round_day: 9.to_s,
#               round_date: Date.new(2019, 2, 11),
#               tournament_id: cblol_2019_1.id
# )

# promotion series  in split 1 - 2019
Round.create!(round_stage: playoffs,
              round_day: "promoção",
              round_date: Date.new(2019, 4, 27),
              tournament_id: cblol_2019_1.id
) 

# seed rounds table for 2019 split 2
puts "Seeding rounds table for 2019 split 2"

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
puts "Seeding rounds table for 2020 split 1"

s2020_1_dates_points = [
          [1,25],
          [1,26],
          [2,1],
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
puts "Seeding rounds table for 2020 split 2"

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


puts "Seeding casts"

# seed for casts tables
def seed_casts(array)
  array.each_with_index do |cast_id, index|
      response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=#{cast_id}&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics&maxResults=100")
      video = JSON.parse(response.body)
      
      year = video["items"].first["snippet"]["publishedAt"][0..3].to_i
      month = video["items"].first["snippet"]["publishedAt"][5..6].to_i
      day = video["items"].first["snippet"]["publishedAt"][8..9].to_i
      date = Date.new(year, month, day)

      duration = video["items"].first["contentDetails"]['duration']

      Cast.create!(cast_url: video["items"].first["id"],
                  cast_date: date,
                  cast_time: ISO8601::Duration.new(duration).to_seconds,
                  cast_view: video["items"].first["statistics"]["viewCount"].to_i,
                  cast_like: video["items"].first["statistics"]["likeCount"].to_i,
                  cast_dislike: video["items"].first["statistics"]["dislikeCount"].to_i,
                  cast_comment: video["items"].first["statistics"]["commentCount"].to_i,
                  round_id: index+1
      )
  end
end

# casts_ids_2019_1
casts_ids = ["tGsGeGnV43o", "q5rp5Bz2UJ0", 
              "si6ZeXANXxs", "PSqifma3hIw", 
              "p10GM_k2zvc", "NFnwNkYrpT4", 
              "NL0GPjs-4Ao", "POeX9tvodSc", 
              "pyN8tcBQ1mk", "5av3YLvBpv4", 
              "Pv_8q7d9VUQ", "8F47LxkjCMc", 
              "Bq6Wl2U-yQ4", "phwSPTyqzJo", 
              "NqMEiWk4DUY", "-kZDQ87gYTQ", "hHNHX9a3o4Y", 
              "w1kmkMFGPzo", "9Mma9Lk36V4",
              "NOaNywpkPWc", "Zf3gC5ANkbg",
              "lnyhNVUp28I", "M7ylOFR-v98",
              "hgJUToNgMhs", "JFcu61p4Pw8",
# casts_ids_2019_2
              "ovAX_jxM_Iw", "bArlhEh4ukQ",
              "Zv_C0JKm-T0", "MzMCZ5KF7HA",
              "73UnuYSJxas", "UEANqE4_GvE",
              "T0UlCzcll5A", "TT1wEuNFtQ8",
              "TOyKE6r7Vkw", "5rNC1u8MsY8",
              "i3a_zIWJEEY", "BvaAoWQM1UI",
              "LdXJo6tfQBs", "wQPt2hmMyk0",
              "URgEDR4al48", "sk5uo-9tA6o",
              "PzjWvectF3c", "o-8aWxjo_V4",
              "WEa-7G9cu1Q", "LG6xpQQ755E",
              "D3LYHZsY-gE",
              "j1NLSuO_hjs", "a-bcicoTxwg",
              "n2D_LNxS8_s", "bAOic1hVkcg",
# casts_ids_2020_1 
              "sDQUz_VKtUM", "kPHxCfkofTw",
              "TE67O6srtSY", "OWdMxkbx-qI",
              "CC_dLdnn2I4", "wyQPEThm-ck",
              "ASMYlu5NbFQ", "38NptWZ-hhs",
              "7zeWdeAguwY", "XC6-JUd8QDI",
              "c7dRntoS_UI", "rkCYJcYmavc",
              "DnIc_5o0GsI", "4miQHp1fCpU", "gUEV2FRohvc",
              "TJJ28nKJbA8", "3tjLlnqjnLM", "S7fglaeBkWw",
              "ZRw_XWw7hrA", "PgLslAkGRgo", "EPULu1wVxJs",
              "WFeTYp-rDSQ", "T3-RBtlVJck", 
              "EGwCjoIYXIg", "hZitcwYFJqw",
# casts_ids_2020_2 
              "VYqYL8V2lD8", "UBm5DAEgNII",
              "lyA_iusFGt0", "AwzdJ_O-Ji8",
              "QIcgRApgjI4", "0yHW9d2qx3g",
              "YxULWMbQAyg", "nLXM8z7XG7A",
              "ZF22BOarorQ", "vVeSguyzXNE",
              "GkiNQdelIkw", "yURmesQKeAk",
              "gekVSFUrTfY", "BUscwechVXU",
              "crEdhjqndB0", "qbMTpwgpZ0E",
              "Pe8Dc42I4b4", "DcxpvJb6wZo",
              "yInrbIvVPYE", "voOlv-B-Q9Y",
              "fz_4tSiYDvU",
              "ojuYAskQZbY", "2tr1pl4GQcA",
              "OhBXywBd7Ac"
]

seed_casts(casts_ids)

# seeding matches
#     playlist_19_1 = "PLC6tQcehKF2Oq8caBG2AUQW3Vof4Pq8YC"
#     playlist_19_2 = "PLC6tQcehKF2Pl9I5RrL6nxgH7WB_FDpEK"
#     playlist_20_1 = "PLC6tQcehKF2Mowe-FmUHCx3ZxVxNW6wF7"
#     playlist_20_2 = "PLC6tQcehKF2PHTyIN__dexPnzhjiLS-iu"

#     # playlists_ids = [playlist_19_1, playlist_19_2, playlist_20_1, playlist_20_2]

#     playlists_ids = [playlist_19_1]

#     matches_ids = []

#     playlists_ids.each do |id|
#       response = HTTParty.get("https://www.googleapis.com/youtube/v3/playlistItems?playlistId=#{id}&key=#{ENV['YOUTUBE_KEY']}&part=contentDetails&maxResults=100")
#       list = JSON.parse(response.body)

#       list["items"].each do |video|
#         matches_ids << video["contentDetails"]["videoId"]
#       end
#     end

#     array = []

#     matches_ids.each do |id|
#       response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=#{id}&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics&maxResults=100")
#       video = JSON.parse(response.body)
      
#       # year = video["items"].first["snippet"]["publishedAt"][0..3].to_i
#       # month = video["items"].first["snippet"]["publishedAt"][5..6].to_i
#       # day = video["items"].first["snippet"]["publishedAt"][8..9].to_i
#       # date = Date.new(year, month, day)

#       # duration = video["items"].first["contentDetails"]['duration']
      
#       array << video["items"].first["snippet"]["publishedAt"][0...10]
#       # array << video["items"].first["snippet"]["tags"][-2]

#       # Match.create! (match_url:
#       #               match_date:
#       #               match_time:
#       #               match_view:
#       #               match_like:
#       #               match_dislike:
#       #               match_comment:
#       #               blue_team_id:
#       #               red_team_id:
#       #               cast_id:
#       # )

#     end