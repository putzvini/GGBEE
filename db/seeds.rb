# seed for teams table
puts "Creating teams"

# team array = name, longa_name, tag and photo path
cnb = Team.create!(team_name: "cnb",
      team_long_name: "cnb e-sports",
      team_tag: "cnb"
      )
fla = Team.create!(team_name: "flamengo",
      team_long_name: "flamengo e-sports",
      team_tag: "fla"
      )
fur = Team.create!(team_name: "furia",
      team_long_name: "furia e-sports",
      team_tag: "fur"
      )
itz = Team.create!(team_name: "intz",
      team_long_name: "intz",
      team_tag: "itz"
      )
kbm = Team.create!(team_name: "kabum",
      team_long_name: "kabum e-sports",
      team_tag: "kbm"
      )
png = Team.create!(team_name: "pain",
      team_long_name: "pain gaming",
      team_tag: "png"
      )
prg = Team.create!(team_name: "prodigy",
      team_long_name: "prodigy e-sports",
      team_tag: "prg"
      )
rdp = Team.create!(team_name: "redemption",
      team_long_name: "redemption e-sports",
      team_tag: "rdp"
      )
san = Team.create!(team_name: "santos",
      team_long_name: "santos hotforex",
      team_tag: "san"
      )
one = Team.create!(team_name: "team one",
      team_long_name: "team one e-sports",
      team_tag: "one"
      )
up = Team.create!(team_name: "uppercut",
      team_long_name: "uppercut e-sports",
      team_tag: "up"
      )
vk = Team.create!(team_name: "keyd",
      team_long_name: "vivo keyd",
      team_tag: "vk"
      )

# seed for players table
puts "Creating players"

p_cnb = [
  ['unknown', 'player'],
  ['unknown', 'player'],
  ['unknown', 'player'],
  ['unknown', 'player'],
  ['unknown', 'player']
 ]
p_fla = [
  ["felipe", "bankai" ],
  ['filipe', 'ranger'],
  ['bruno','goku'],
  ['han','luci'],
  ['ju','bvoy']
]
p_fur = [ 
  ['william', 'tyrin'],
  ['luis', 'st1ing'],
  ['ruan', 'anyyy'],
  ['joao', 'alternative'],
  ['yan', 'damage']
]
p_itz = [ 
  ['rodrigo', 'tay'],
  ['yuri', 'yupps'],
  ['diogo', 'shini'],
  ['bruno', 'envy'],
  ['micael', 'micao']
]
p_kbm = [ 
  ['lee', 'parang'],
  ['na', 'wiz'],
  ['arthur', 'tutsz'],
  ['igor', 'dudstheboy'],
  ['denilson', 'ceos']
]
p_png = [ 
  ['leonardo', 'robo'],
  ['marcos', 'cariok'],
  ['thaigo', 'tinows'],
  ['felipe', 'brtt'],
  ['eidi', 'esa']
]
p_prg = [ 
  ['francisco', 'fnb'],
  ['yan', 'yampi'],
  ['matheus', 'dynquedo'],
  ['humberto', 'garo'],
  ['willyam', 'wos']
]
p_rdp = [ 
  ['bruno', 'glow'],
  ['marcos', 'krastyel'],
  ['diego', 'sephis'],
  ['alan', 'riva'],
  ['emerson', 'bocajr']
]
p_san = [ 
  ['park', 'jackpot'],
  ['benjamin', 'hyoga'],
  ['kim', 'rainbow'],
  ['matheus', 'sarkis'],
  ['gabriel', 'hawk']
]
p_one = [ 
  ['matheus', 'skybart'],
  ['wyllian', 'wyll'],
  ['bruno', 'brucer'],
  ['pablo', 'pbo'],
  ['gabriel', 'jojo']
]
p_up = [
  ['unknown', 'player'],
  ['unknown', 'player'],
  ['unknown', 'player'],
  ['unknown', 'player'],
  ['unknown', 'player']
]
p_vk = [ 
  ['leonardo', 'hidan'],
  ['gustavo', 'minerva'],
  ['julio', 'nosferus'],
  ['augusto', 'klaus'],
  ['gabriel', 'turtle']
]

def seed_player(array, team)
  array.each do |p|
    Player.create!(
      player_name: p[0],
      player_nick: p[1],
      team_id: team.id
    )
  end
end

seed_player(p_cnb, cnb)
seed_player(p_fla, fla)
seed_player(p_fur, fur)
seed_player(p_itz, itz)
seed_player(p_kbm, kbm)
seed_player(p_png, png)
seed_player(p_prg, prg)
seed_player(p_rdp, rdp)
seed_player(p_san, san)
seed_player(p_one, one)
seed_player(p_up, up)
seed_player(p_vk, vk)

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
# seed methods
puts "creating methods for seed"

def seed_db(array)
  array.each_with_index do |hash, i|
    round = Round.create!(round_stage: hash[:stage],
                          round_day: (i + 1).to_s,
                          round_date: hash[:date],
                          tournament_id: hash[:tournament]
            )
    
    puts "Round #{round.id} created"

    cast_response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=#{hash[:cast_url]}&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics")
    cast_video = JSON.parse(cast_response.body)

    cast_duration = cast_video["items"].first["contentDetails"]['duration']

    cast = Cast.create!(cast_url: cast_video["items"].first["id"],
                        cast_date: hash[:date],
                        cast_time: ISO8601::Duration.new(cast_duration).to_seconds,
                        cast_view: cast_video["items"].first["statistics"]["viewCount"].to_i,
                        cast_like: cast_video["items"].first["statistics"]["likeCount"].to_i,
                        cast_dislike: cast_video["items"].first["statistics"]["dislikeCount"].to_i,
                        cast_comment: cast_video["items"].first["statistics"]["commentCount"].to_i,
                        round_id: round.id
           )

    puts "Cast date #{cast.cast_date} created"

    hash[:matches].each do |match|
      match_response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=#{match[:match_url]}&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics")
      match_video = JSON.parse(match_response.body)

      match_duration = match_video["items"].first["contentDetails"]['duration']

      Match.create!(match_url: match_video["items"].first["id"],
                    match_date: hash[:date],
                    match_time: ISO8601::Duration.new(match_duration).to_seconds,
                    match_view: match_video["items"].first["statistics"]["viewCount"].to_i,
                    match_like: match_video["items"].first["statistics"]["likeCount"].to_i,
                    match_dislike: match_video["items"].first["statistics"]["dislikeCount"].to_i,
                    match_comment: match_video["items"].first["statistics"]["commentCount"].to_i,
                    blue_team_id: match[:blue_team].id,
                    red_team_id: match[:red_team].id,
                    cast_id: cast.id
      )
      puts "Match created!"
    end
  end
end
# creating seed variables
puts "Creating variables"

points = "points"
playoffs = "playoffs"
promotion = "promotion series"

s2019_1 = [
  {
    date: Date.new(2019,1,12),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "tGsGeGnV43o",
    matches: [
      {
        match_url: "XQ0KshJ0Z8Y",
        blue_team: fla,
        red_team: kbm
      },
      {
        match_url: "SItX0OFomlk",
        blue_team: vk,
        red_team: up
      },
      {
        match_url: "nzYvhP6NLWg",
        blue_team: itz,
        red_team: cnb
      },
      {
        match_url: "9F2WyiwDjzo",
        blue_team: prg,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,1,13),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "q5rp5Bz2UJ0",
    matches: [
      {
        match_url: "MvDHyYtUjVg",
        blue_team: up,
        red_team: kbm
      },
      {
        match_url: "V5DEa3H5cyY",
        blue_team: vk,
        red_team: cnb
      },
      {
        match_url: "2A5iSBnl3sw",
        blue_team: rdp,
        red_team: itz
      },
      {
        match_url: "18mo1ZekMJg",
        blue_team: fla,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2019,1,19),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "si6ZeXANXxs",
    matches: [
      {
        match_url: "VARmvWkb_5E",
        blue_team: rdp,
        red_team: cnb
      },
      {
        match_url: "xy5womYBDE8",
        blue_team: itz,
        red_team: prg
      },
      {
        match_url: "LHuLRdXOXy0",
        blue_team: up,
        red_team: fla
      },
      {
        match_url: "EU4LbvD5Src",
        blue_team: vk,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2019,1,20),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "PSqifma3hIw",
    matches: [
      {
        match_url: "WDzRCStOjZY",
        blue_team: up,
        red_team: prg
      },
      {
        match_url: "-UBWW1S-JWM",
        blue_team: rdp,
        red_team: fla
      },
      {
        match_url: "4TU7CX3LW8k",
        blue_team: cnb,
        red_team: kbm
      },
      {
        match_url: "bHQU_xXvQ-s",
        blue_team: vk,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019,1,26),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "p10GM_k2zvc",
    matches: [
      {
        match_url: "QFE7csj3WlI",
        blue_team: vk,
        red_team: prg
      },
      {
        match_url: "8kVvodRqIN4",
        blue_team: rdp,
        red_team: kbm
      },
      {
        match_url: "BGutdWZNT0A",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "0q3wjINcT54",
        blue_team: cnb,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,1,27),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "NFnwNkYrpT4",
    matches: [
      {
        match_url: "hlOXxfVUHqc",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "IRQXEPt15H8",
        blue_team: cnb,
        red_team: prg
      },
      {
        match_url: "LTm0YOg0fq4",
        blue_team: vk,
        red_team: fla
      },
      {
        match_url: "Z5_Z2PxJZn4",
        blue_team: rdp,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,2,2),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "NL0GPjs-4Ao",
    matches: [
      {
        match_url: "WgcAHTUZN74",
        blue_team: fla,
        red_team: cnb
      },
      {
        match_url: "VV7nFMzD70c",
        blue_team: itz,
        red_team: up
      },
      {
        match_url: "rlgRU4BQf4o",
        blue_team: prg,
        red_team: kbm
      },
      {
        match_url: "iGmNhvuGEf4",
        blue_team: rdp,
        red_team: vk
      }
    ]
  },
  {
    date: Date.new(2019,2,3),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "POeX9tvodSc",
    matches: [
      {
        match_url: "LSIEgfORskE",
        blue_team: kbm,
        red_team: fla
      },
      {
        match_url: "-8bbZZ1ZRZk",
        blue_team: rdp,
        red_team: prg
      },
      {
        match_url: "R6cBhidPcgw",
        blue_team: up,
        red_team: vk
      },
      {
        match_url: "L3CybUO90cs",
        blue_team: cnb,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019,2,9),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "pyN8tcBQ1mk",
    matches: [
      {
        match_url: "MTOJU0OQOwc",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "mR3FfynhMMI",
        blue_team: cnb,
        red_team: vk
      },
      {
        match_url: "G1hdjGB5uVY",
        blue_team: kbm,
        red_team: up
      },
      {
        match_url: "W3FBiFufid4",
        blue_team: prg,
        red_team:  fla
      },
    ]
  },
  {
    date: Date.new(2019,2,10),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "5av3YLvBpv4",
    matches: [
      {
        match_url: "L6LIdHJH9Bk",
        blue_team: prg,
        red_team: itz
      },
      {
        match_url: "hVL9uIVJAMY",
        blue_team: kbm,
        red_team: vk
      },
      {
        match_url: "cRXBg7txDtI",
        blue_team: fla,
        red_team: up
      },
      {
        match_url: "cRXBg7txDtI",
        blue_team: cnb,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,2,16),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "Pv_8q7d9VUQ",
    matches: [
      {
        match_url: "Vc8IkxKXHj8",
        blue_team: prg,
        red_team: up
      },
      {
        match_url: "qJMQRshY6Gg",
        blue_team: kbm,
        red_team: cnb
      },
      {
        match_url: "UkbM9fJ7a0U",
        blue_team: itz,
        red_team: vk
      },
      {
        match_url: "7Px1GPM0Kcg",
        blue_team: fla,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,2,17),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "8F47LxkjCMc",
    matches: [
      {
        match_url: "fVhHllcJ7mA",
        blue_team: kbm,
        red_team: rdp
      },
      {
        match_url: "DS8vZ1SZT9M",
        blue_team: up,
        red_team: cnb
      },
      {
        match_url: "OEhpzOOfJ9s",
        blue_team: prg,
        red_team: vk
      },
      {
        match_url: "XNg1qLmk1Qg",
        blue_team: itz,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,2,23),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "Bq6Wl2U-yQ4",
    matches: [
      {
        match_url: "GTXbJdsmyrk",
        blue_team: vk,
        red_team: fla
      },
      {
        match_url: "xtwYXvaQuA0",
        blue_team: up,
        red_team: rdp
      },
      {
        match_url: "raSvieL_Zlc",
        blue_team: prg,
        red_team: cnb
      },
      {
        match_url: "zPkeAk84ccQ",
        blue_team: kbm,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019,2,24),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "phwSPTyqzJo",
    matches: [
      {
        match_url: "1KUm1vA1QKk",
        blue_team: vk,
        red_team: rdp
      },
      {
        match_url: "bBO9lrDIIg8",
        blue_team: up,
        red_team: itz
      },
      {
        match_url: "-cCSryJgW1s",
        blue_team: kbm,
        red_team: prg
      },
      {
        match_url: "GBKvvADTJkQ",
        blue_team: cnb,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,3,8),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "NqMEiWk4DUY",
    matches: [
      {
        match_url: "hJg7Q8zu2mM",
        blue_team: prg,
        red_team: rdp
      },
      {
        match_url: "G-iVVI5QHNQ",
        blue_team: vk,
        red_team: up
      },
      {
        match_url: "W6p5G8Woshg",
        blue_team: cnb,
        red_team: itz
      },
      {
        match_url: "1Wd7pmo_4DQ",
        blue_team: fla,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2019,3,9),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "-kZDQ87gYTQ",
    matches: [
      {
        match_url: "Mts4aIJd93w",
        blue_team: vk,
        red_team: cnb
      },
      {
        match_url: "pPqDaMbDor0",
        blue_team: fla,
        red_team: prg
      },
      {
        match_url: "PPdtDMJ8cS4",
        blue_team: up,
        red_team: kbm
      },
      {
        match_url: "MUJF2Jua8xw",
        blue_team: itz,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,3,10),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "hHNHX9a3o4Y",
    matches: [
      {
        match_url: "FHkehJwXwf4",
        blue_team: fla,
        red_team: up
      },
      {
        match_url: "ra5dEqLdWiU",
        blue_team: rdp,
        red_team: cnb
      },
      {
        match_url: "I1aqPoMCcSQ",
        blue_team: kbm,
        red_team: vk
     },
      {
        match_url: "1c3k1wCwUPU",
        blue_team: itz,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2019,3,16),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "w1kmkMFGPzo",
    matches: [
      {
        match_url: "8rUT1Ekokqs",
        blue_team: vk,
        red_team: itz
      },
      {
        match_url: "_PRq6vh33bg",
        blue_team: cnb,
        red_team: kbm
      },
      {
        match_url: "ivrpupxTmD8",
        blue_team: up,
        red_team: prg
     },
      {
        match_url: "xlZgHZOklyo",
        blue_team: fla,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,3,17),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "9Mma9Lk36V4",
    matches: [
      {
        match_url: "-pv1AriVLmY",
        blue_team: cnb,
        red_team: up
      },
      {
        match_url: "Pvp-NihjBeU",
        blue_team: itz,
        red_team: fla
      },
      {
        match_url: "u7zDMqrWngI",
        blue_team: kbm,
        red_team: rdp
      },
      {
        match_url: "PiBDoUgV9Pk",
        blue_team: prg,
        red_team: vk
      }
    ]
  },
  {
    date: Date.new(2019,3,23),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "NOaNywpkPWc",
    matches: [
      {
        match_url: "_p8CUx673Jo",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "2ibs7mCDpsk",
        blue_team: rdp,
        red_team: up
      },
      {
        match_url: "NW0R_hR44i4",
        blue_team: cnb,
        red_team: prg
      },
      {
        match_url: "w6X96moIo1w",
        blue_team: vk,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,3,24),
    stage: points,
    tournament: cblol_2019_1.id,
    cast_url: "Zf3gC5ANkbg",
    matches: [
      {
        match_url: "EWc5PLPHbYs",
        blue_team: prg,
        red_team: kbm
      },
      {
        match_url: "ae3gBx5Zy8A",
        blue_team: rdp,
        red_team: vk
      },
      {
        match_url: "e7m-yuLTTHs",
        blue_team: fla,
        red_team: cnb
      },
      {
        match_url: "79LNWzjW03Q",
        blue_team: itz,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,4,6),
    stage: playoffs,
    tournament: cblol_2019_1.id,
    cast_url: "lnyhNVUp28I",
    matches: [
      {
        match_url: "Wn3cF9lCTv4",
        blue_team: fla,
        red_team: cnb
      },
      {
        match_url: "egaR0loZLRs",
        blue_team: cnb,
        red_team: fla
      },
      {
        match_url: "SKn46Rfp5GM",
        blue_team: fla,
        red_team: cnb
      }
    ]
  },
  {
    date: Date.new(2019,4,7),
    stage: playoffs,
    tournament: cblol_2019_1.id,
    cast_url: "M7ylOFR-v98",
    matches: [
      {
        match_url: "7rT_brmK6uo",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "75S690YinvU",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "rn3GzGQbIrI",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "Pxsc9Acb_jI",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "L8ZxpEWyQfk",
        blue_team: rdp,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019,4,13),
    stage: playoffs,
    tournament: cblol_2019_1.id,
    cast_url: "hgJUToNgMhs",
    matches: [
      {
        match_url: "43CX71jd9zY",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "Gh-EcKPswu0",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "xTpnmockzqk",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "UPWSd3hUYR0",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "c0HrDLrGWdE",
        blue_team: fla,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019, 04, 27),
    stage: promotion,
    tournament: cblol_2019_1.id,
    cast_url: "JFcu61p4Pw8",
    matches: [
      {
        match_url: "pry8CNWXMnc",
        blue_team: vk,
        red_team: one
      },
      {
        match_url: "iGF_NxkErGI",
        blue_team: vk,
        red_team: one
      },
      {
        match_url: "y-WRCMcmPck",
        blue_team: vk,
        red_team: one
      },
      {
        match_url: "i6v-Urg93mk",
        blue_team: one,
        red_team: vk
      }
    ]
  }
]
# calling method for s2019 - split 1
puts "calling method for s2019 - split 1"
seed_db(s2019_1)

s2019_2 = [
  {
    date: Date.new(2019,6,1),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "ovAX_jxM_Iw",
    matches: [
      {
        match_url: "qLrO1uIOYis",
        blue_team: fla,
        red_team: png
      },
      {
        match_url:"sAo_YkEkBE8",
        blue_team: up,
        red_team: cnb
      },
      {
        match_url: "WVaPCtJeJHk",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "Szx9SaXC5q4",
        blue_team: one,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2019,6,2),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "bArlhEh4ukQ",
    matches: [
      {
        match_url: "9kmX1t_mZP0" ,
        blue_team: png,
        red_team: cnb
      },
      {
        match_url: "NXR_u8r9CnI",
        blue_team: up,
        red_team: one
      },
      {
        match_url: "s8kFYU32ZBs",
        blue_team: rdp,
        red_team: kbm
      },
      {
        match_url: "ux5JLo5g9to",
        blue_team: itz,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,6,8),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "Zv_C0JKm-T0",
    matches: [
      {
        match_url: "fWbFhjOAOIk",
        blue_team: rdp,
        red_team: one
      },
      {
        match_url: "hUnnCBB1C0M",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "5b1-w46lNgo",
        blue_team: cnb,
        red_team: fla
      },
      {
        match_url: "MgyNNoT3CWc",
        blue_team: png,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,6,9),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "MzMCZ5KF7HA",
    matches: [
      {
        match_url: "tAsbteEWttU",
        blue_team: itz,
        red_team: cnb
      },
      {
        match_url: "G7ts5BTHAKA",
        blue_team: fla,
        red_team: rdp
      },
      {
        match_url: "Axb8M6c4S88",
        blue_team: one,
        red_team: png
      },
      {
        match_url: "4yo6nVMAvX8",
        blue_team: up,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2019,6,15),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "73UnuYSJxas",
    matches: [
      {
        match_url: "9HtLf69boug",
        blue_team: itz,
        red_team: up
      },
      {
        match_url: "iVCaNB2sbts",
        blue_team: png,
        red_team: rdp
      },
      {
        match_url: "wgT2rmqchi4",
        blue_team: kbm,
        red_team: fla
      },
      {
        match_url: "qv_-nGATwKU",
        blue_team: cnb,
        red_team: one
      }
    ]
  },
  {
    date: Date.new(2019,6,16),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "UEANqE4_GvE",
    matches: [
      {
        match_url: "vuXk849Ord0",
        blue_team: kbm,
        red_team: png
      },
      {
        match_url: "5jETQvIbFBQ",
        blue_team: one,
        red_team: itz
      },
      {
        match_url: "xOOWOG5w8Ak",
        blue_team: fla,
        red_team: up
      },
      {
        match_url: "q4C4QQHX26c",
        blue_team: rdp,
        red_team: cnb
      }
    ]
  },
  {
    date: Date.new(2019,6,22),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "T0UlCzcll5A",
    matches: [
      {
        match_url: "vEfmnVjQlJs",
        blue_team: fla,
        red_team: one
      },
      {
        match_url: "ElFy3GLs7X0",
        blue_team: cnb,
        red_team: kbm
      },
      {
        match_url: "_4R4jS2rFAU",
        blue_team: png,
        red_team: itz
      },
      {
        match_url: "kuUB6HFkBxE",
        blue_team: up,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,6,23),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "TT1wEuNFtQ8",
    matches: [
      {
        match_url: "lZI8VzdMfBA",
        blue_team: png,
        red_team: fla
      },
      {
        match_url: "mVw9zUHa3xs",
        blue_team: rdp,
        red_team: itz
      },
      {
        match_url: "yMP82fPeGPI",
        blue_team: cnb,
        red_team: up
      },
      {
        match_url: "tQ-M4ctqad8",
        blue_team: kbm,
        red_team: one
      }
    ]
  },
  {
    date: Date.new(2019,6,29),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "TOyKE6r7Vkw",
    matches: [
      {
        match_url: "SAA7xMdcGaI",
        blue_team: kbm,
        red_team: rdp
      },
      {
        match_url: "wSUKKzLktMQ",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "byuFhcEVQ2Q",
        blue_team: one,
        red_team: up
      },
      {
        match_url: "cLd6BDvEO7k",
        blue_team: cnb,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2019,6,30),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "5rNC1u8MsY8",
    matches: [
      {
        match_url: "3EwfuHp3FNU",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "I1PXok9oZ8A",
        blue_team: up,
        red_team: png
      },
      {
        match_url: "C_m6qw1-MkE",
        blue_team: fla,
        red_team: cnb
      },
      {
        match_url: "0sIzqQPkJds",
        blue_team: one,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,7,6),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "i3a_zIWJEEY",
    matches: [
      {
        match_url: "-bM96-C2YJQ",
        blue_team: cnb,
        red_team: itz
      },
      {
        match_url: "yHZKqVvoE3A",
        blue_team: png,
        red_team: one
      },
      {
        match_url: "I41zTwfT4_A",
        blue_team: kbm,
        red_team: up
      },
      {
        match_url: "IhY2h7fLCx0",
        blue_team: rdp,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,7,7),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "BvaAoWQM1UI",
    matches: [
      {
        match_url: "0BDA_ZZNakM",
        blue_team: one,
        red_team: cnb
      },
      {
        match_url: "-0jCRWK0BLg",
        blue_team: fla,
        red_team: kbm
      },
      {
        match_url: "cOY6L2AkPvo",
        blue_team: rdp,
        red_team: png
      },
      {
        match_url: "HqI5nbM3Pyk",
        blue_team: up,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019,7,13),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "LdXJo6tfQBs",
    matches: [
      {
        match_url: "LnZGXg9CjvQ",
        blue_team: up,
        red_team: fla
      },
      {
        match_url: "kYHlh1tOIqo",
        blue_team: cnb,
        red_team: rdp
      },
      {
        match_url: "rMJCxi6zIsQ",
        blue_team: itz,
        red_team: one
      },
      {
        match_url: "0me4snzESXk",
        blue_team: png,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2019,7,14),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "wQPt2hmMyk0",
    matches: [
      {
        match_url: "iiq4q0H_rPM",
        blue_team: rdp,
        red_team: up
      },
      {
        match_url: "7ylzbkJgty8",
        blue_team: kbm,
        red_team: cnb
      },
      {
        match_url: "i4Q_WAdW2vU",
        blue_team: itz,
        red_team: png
      },
      {
        match_url: "u-Fe2_aELvc",
        blue_team: one,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,7,20),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "URgEDR4al48",
    matches: [
      {
        match_url: "gPMmDcPsOjI",
        blue_team: rdp,
        red_team: itz
      },
      {
        match_url: "jYO59fhxEjw",
        blue_team: up,
        red_team: cnb
      },
      {
        match_url: "R1tZSkzWkuw",
        blue_team: kbm,
        red_team: one
      },
      {
        match_url: "3-gPp69TvZc",
        blue_team: fla,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2019,7,21),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url:  "sk5uo-9tA6o",
    matches: [
      {
        match_url: "oXMUa-1ck10",
        blue_team: up,
        red_team: one
      },
      {
        match_url: "ZXyOAbRooGQ",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "-9eNI6so4SA",
        blue_team: kbm,
        red_team: rdp
      },
      {
        match_url: "47NPgTb4TTM",
        blue_team: cnb,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2019,7,27),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "PzjWvectF3c",
    matches: [
      {
        match_url: "FBBT1ZFc764",
        blue_team: cnb,
        red_team: fla
      },
      {
        match_url: "Qk280K2gstc",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "re8Wk6X166E",
        blue_team: png,
        red_team: up
      },
      {
        match_url: "N9Ua8CsWX1s",
        blue_team: one,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2019,7,28),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "o-8aWxjo_V4",
    matches: [
      {
        match_url: "F_pNn2loYNI",
        blue_team: kbm,
        red_team: up
      },
      {
        match_url: "aLfAd7jXgpg",
        blue_team: png,
        red_team: one
      },
      {
        match_url: "r7r7ml60dz0",
        blue_team: cnb,
        red_team: itz
      },
      {
        match_url: "XKtc8sOPkHU",
        blue_team: rdp,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2019,8,3),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "WEa-7G9cu1Q",
    matches: [
      {
        match_url: "JqNgeWwGUAs",
        blue_team: cnb,
        red_team: one
      },
      {
        match_url: "bsuQqp7MBRQ",
        blue_team: fla,
        red_team: kbm
      },
      {
        match_url: "kZpwCFTozUg",
        blue_team: rdp,
        red_team: png
      },
      {
        match_url: "BiooFxiWkgY",
        blue_team: itz,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,8,4),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "LG6xpQQ755E",
    matches: [
      {
        match_url: "2D0am1u_4eE",
        blue_team: png,
        red_team: kbm
      },
      {
        match_url: "mF7armKilL0",
        blue_team: cnb,
        red_team: rdp
      },
      {
        match_url: "QZlC6AAyPt8",
        blue_team: one,
        red_team: itz
      },
      {
        match_url: "yaexxKmqf7I",
        blue_team: fla,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,8,10),
    stage: points,
    tournament: cblol_2019_2.id,
    cast_url: "D3LYHZsY-gE",
    matches: [
      {
        match_url: "1sR2ZksBBdk",
        blue_team: up,
        red_team: rdp
      },
      {
        match_url: "ig9y8iHtYUE",
        blue_team: one,
        red_team: fla
      },
      {
        match_url: "18TOdjsAqng",
        blue_team: kbm,
        red_team: cnb
      },
      {
        match_url: "GLfM062z1No",
        blue_team: itz,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2019,8,24),
    stage: playoffs,
    tournament: cblol_2019_2.id,
    cast_url: "j1NLSuO_hjs",
    matches: [
      {
        match_url: "8CR8laEcinU",
        blue_team: fla,
        red_team: up
      },
      {
        match_url: "hBd5NMGdkCQ",
        blue_team: up,
        red_team: fla
      },
      {
        match_url: "qriCifwJ3_s",
        blue_team: fla,
        red_team: up
      }
    ]
  },
  {
    date: Date.new(2019,8,25),
    stage: playoffs,
    tournament: cblol_2019_2.id,
    cast_url: "a-bcicoTxwg",
    matches: [
      {
        match_url: "Gwr9FVXXu_Y",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "b3g7x67QdA0",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "PuKXSN6Im6M",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "sJ7aDodjPT0",
        blue_team: itz,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2019,9,7),
    stage: playoffs,
    tournament: cblol_2019_2.id,
    cast_url: "n2D_LNxS8_s",
    matches: [
      {
        match_url: "95Zn48mcEwk",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "UqtjIlh5-iM",
        blue_team: itz,
        red_team: fla
      },
      {
        match_url: "3BaE-NJEhfg",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "CISZAu_FZ9k",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "2PheHyTbjkQ",
        blue_team: fla,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2019,9,21),
    stage: promotion,
    tournament: cblol_2019_2.id,
    cast_url: "bAOic1hVkcg",
    matches: [
      {
        match_url: "aR66RsO0ITs",
        blue_team: cnb,
        red_team: vk
      },
      {
        match_url: "n0atx3-TESs",
        blue_team: cnb,
        red_team: vk
      },
      {
        match_url: "ZGtQUNf7pC4",
        blue_team: cnb,
        red_team: vk
      },
      {
        match_url: "Ybf5Ux91T4I",
        blue_team: cnb,
        red_team: vk
      }
    ]
  },
]
# calling method for s2019 - split 2
puts "calling method for s2019 - split 2"
seed_db(s2019_2)

s2020_1 = [
  {
    date: Date.new(2020,1,25),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "sDQUz_VKtUM",
    matches: [
      {
        match_url: "nYc34K3_ZAQ",
        blue_team: png,
        red_team: fla
      },
      {
        match_url: "aBYiYp-94sM",
        blue_team: prg,
        red_team: vk
      },
      {
        match_url: "rH_GMWaYNGM",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "so4jq13TWbg",
        blue_team: fur,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,1,26),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "kPHxCfkofTw",
    matches: [
      {
        match_url: "XiH86X7VfpU",
        blue_team: fla,
        red_team: vk
      },
      {
        match_url: "cIUjHNbyevc",
        blue_team: prg,
        red_team: fur
      },
      {
        match_url: "Xrpdb5ri7XE",
        blue_team: rdp,
        red_team: kbm
      },
      {
        match_url: "pBrHDxUtscA",
        blue_team: itz,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,2,1),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "TE67O6srtSY",
    matches: [
      {
        match_url: "ASQgjgH8QWU",
        blue_team: rdp,
        red_team: fur
      },
      {
        match_url: "slEAGBbzmj8",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "NutqfNnyEBg",
        blue_team: vk,
        red_team: png
      },
      {
        match_url: "CIwmed0bwMI",
        blue_team: fla,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2020,2,2),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "OWdMxkbx-qI",
    matches: [
      {
        match_url: "jJcq9Qam3B8",
        blue_team: vk,
        red_team: itz
      },
      {
        match_url: "HqMjzme9qxc",
        blue_team: png,
        red_team: rdp
      },
      {
        match_url: "KORoNYhvFNs",
        blue_team: fur,
        red_team: fla
      },
      {
        match_url: "eZXr2-wWj9Q",
        blue_team: prg,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,2,8),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "CC_dLdnn2I4",
    matches: [
      {
        match_url: "cTzeWaEDyhc",
        blue_team: itz,
        red_team: prg
      },
      {
        match_url: "JTYbgD8I628",
        blue_team: fla,
        red_team: rdp
      },
      {
        match_url: "qIiM5cnRQ_0",
        blue_team: kbm,
        red_team: png
      },
      {
        match_url: "dgGTih9oUWw",
        blue_team: vk,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,2,9),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "wyQPEThm-ck",
    matches: [
      {
        match_url: "7kX0rUx2Eg8",
        blue_team: kbm,
        red_team: fla
      },
      {
        match_url: "IDHubcLNGEY",
        blue_team: fur,
        red_team: itz
      },
      {
        match_url: "6xgAa6Kpg_k",
        blue_team: png,
        red_team: prg
      },
      {
        match_url: "G7O6_GLIrj0",
        blue_team: rdp,
        red_team: vk
      }
    ]
  },
  {
    date: Date.new(2020,2,29),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "ASMYlu5NbFQ",
    matches: [
      {
        match_url: "tDVTEHCzj-0",
        blue_team: png,
        red_team: fur
      },
      {
        match_url: "zz5ZDxo3edQ",
        blue_team: vk,
        red_team: kbm
      },
      {
        match_url: "CGdeBY2qxHA",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "xcGQ5ND_Gdk",
        blue_team: prg,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2020,3,1),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "38NptWZ-hhs",
    matches: [
      {
        match_url: "UN7ywPOkZH8",
        blue_team: fla,
        red_team: png
      },
      {
        match_url: "NFxYF2tel6o",
        blue_team: rdp,
        red_team: itz
      },
      {
        match_url: "9E8wziYgVxk",
        blue_team: vk,
        red_team: prg
      },
      {
        match_url: "yAdPHw8WkLQ",
        blue_team: kbm,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,3,7),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "7zeWdeAguwY",
    matches: [
      {
        match_url: "Crudcn_-LP8",
        blue_team: kbm,
        red_team: rdp
      },
      {
        match_url: "qwoa1Hu57VQ",
        blue_team: png,
        red_team: itz
      },
      {
        match_url: "XM6xcmWAkoM",
        blue_team: fur,
        red_team: prg
      },
      {
        match_url: "ZVZClJ_1-FE",
        blue_team: vk,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2020,3,8),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "XC6-JUd8QDI",
    matches: [
      {
        match_url: "u-SXIGg75Qw",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "7ELDRU8D4Lo",
        blue_team: prg,
        red_team: fla
      },
      {
        match_url: "MI7yHdxSGDc",
        blue_team: png,
        red_team: vk
      },
      {
        match_url: "vS-aA0wsNgI",
        blue_team: fur,
        red_team: rdp
      }
    ]
  },
  {
    date: Date.new(2020,3,14),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "c7dRntoS_UI",
    matches: [
      {
        match_url: "sr2_KuxFIcU",
        blue_team: itz,
        red_team: vk
      },
      {
        match_url: "Se7DmtlPtTE",
        blue_team: fla,
        red_team: fur
      },
      {
        match_url: "F5jtoNe3fQo",
        blue_team: kbm,
        red_team: prg
      },
      {
        match_url: "q6gICQPVjoQ",
        blue_team: rdp,
        red_team:png
      }
    ]
  },
  {
    date: Date.new(2020,3,15),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "rkCYJcYmavc",
    matches: [
      {
        match_url: "VVgM9r6yvlE",
        blue_team: fur,
        red_team: vk
      },
      {
        match_url: "w2T9SaNX9yo",
        blue_team: png,
        red_team: kbm
      },
      {
        match_url: "BZHslw6KWQM",
        blue_team: rdp,
        red_team: fla
      },
      {
        match_url: "6r97At9qIxs",
        blue_team: prg,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2020,4,10),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "DnIc_5o0GsI",
    matches: [
      {
        match_url: "JRMaGVMAT4U",
        blue_team: prg,
        red_team: png
      },
      {
        match_url: "lrzEQaQ7d2Y",
        blue_team: vk,
        red_team: rdp
      },
      {
        match_url: "QfiYGIF1seA",
        blue_team: itz,
        red_team: fur
      },
      {
        match_url: "0D7IysZ3BVo",
        blue_team: fur,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,4,11),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "4miQHp1fCpU",
    matches: [
      {
        match_url: "V-RXbQtyfdc",
        blue_team: rdp,
        red_team: prg
      },
      {
        match_url: "OqzCOflRqi0",
        blue_team: kbm,
        red_team: vk
      },
      {
        match_url: "_uABPqEs5aw",
        blue_team: itz,
        red_team: fla
      },
      {
        match_url: "k9rXUe-dpyk",
        blue_team: fur,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,4,12),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "gUEV2FRohvc",
    matches: [
      {
        match_url: "v8R6FhWIl9c",
        blue_team: itz,
        red_team: rdp
      },
      {
        match_url: "LOd8N6Ozp2k",
        blue_team: prg,
        red_team: vk
      },
      {
        match_url: "RpPHyN095II",
        blue_team: fur,
        red_team: kbm
      },
      {
        match_url: "wxbYyhmxnXg",
        blue_team: fla,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,4,17),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "TJJ28nKJbA8",
    matches: [
      {
        match_url: "v0qxfB-A-2I",
        blue_team: fur,
        red_team: prg
      },
      {
        match_url: "UALLgroE26I",
        blue_team: png,
        red_team: itz
      },
      {
        match_url: "SiNvSXEdjPY",
        blue_team: rdp,
        red_team: kbm
      },
      {
        match_url: "uVjwgHph774",
        blue_team: fla,
        red_team: vk
      }
    ]
  },
  {
    date: Date.new(2020,4,18),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "3tjLlnqjnLM",
    matches: [
      {
        match_url: "7yCEAnqhmhQ",
        blue_team: vk,
        red_team: png
      },
      {
        match_url: "zmhZnulpsMQ",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "83VoFKfFR-8",
        blue_team: fla,
        red_team: prg
      },
      {
        match_url: "TYoH9-tU6sg",
        blue_team: rdp,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,4,19),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "S7fglaeBkWw",
    matches: [
      {
        match_url: "FXYFQUL2VSo",
        blue_team: kbm,
        red_team: prg
      },
      {
        match_url: "BlAclB1ds4I",
        blue_team: fla,
        red_team: fur
      },
      {
        match_url: "wsoN7QEiKjU",
        blue_team: itz,
        red_team: vk
      },
      {
        match_url: "8D1SuLs9wog",
        blue_team: rdp,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,4,24),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "ZRw_XWw7hrA",
    matches: [
      {
        match_url: "JJCw8pWFeFA",
        blue_team: fur,
        red_team: vk
      },
      {
        match_url: "UYkh9RWMpLs",
        blue_team: kbm,
        red_team: png
      },
      {
        match_url: "IGTfkNjRC78",
        blue_team: rdp,
        red_team: fla
      },
      {
        match_url: "Xu7Y-7iCl3I",
        blue_team: prg,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2020,4,25),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "PgLslAkGRgo",
    matches: [
      {
        match_url: "PzREwQ7me8o",
        blue_team: fla,
        red_team: kbm
      },
      {
        match_url: "mYDi_81_TUc",
        blue_team: vk,
        red_team: rdp
      },
      {
        match_url: "etZBE4jMhQE",
        blue_team: itz,
        red_team: fur
      },
      {
        match_url: "t-bYgnqEiZg",
        blue_team: png,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2020,4,26),
    stage: points,
    tournament: cblol_2020_1.id,
    cast_url: "EPULu1wVxJs",
    matches: [
      {
        match_url: "2zDU6CGaexI",
        blue_team: prg,
        red_team: rdp
      },
      {
        match_url: "jjuUNAvmBwY",
        blue_team: fur,
        red_team: png
      },
      {
        match_url: "gsgVEeE0vE8",
        blue_team: vk,
        red_team: kbm
      },
      {
        match_url: "EjRN0wIl5pc",
        blue_team: itz,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2020,5,2),
    stage: playoffs,
    tournament: cblol_2020_1.id,
    cast_url: "WFeTYp-rDSQ",
    matches: [
      {
        match_url: "kJMyXyTnISo",
        blue_team: vk,
        red_team: kbm
      },
      {
        match_url: "0j4frcmJ7cg",
        blue_team: vk,
        red_team: kbm
      },
      {
        match_url: "uSToSNKUzOk",
        blue_team: vk,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,5,3),
    stage: playoffs,
    tournament: cblol_2020_1.id,
    cast_url: "T3-RBtlVJck",
    matches: [
      {
        match_url: "olQKtNTph00",
        blue_team: fla,
        red_team: fur
      },
      {
        match_url: "TRuhbDivF5A",
        blue_team: fur,
        red_team: fla
      },
      {
        match_url: "a5hO5Ly9HJA",
        blue_team: fur,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2020,5,9),
    stage: playoffs,
    tournament: cblol_2020_1.id,
    cast_url: "EGwCjoIYXIg",
    matches: [
      {
        match_url: "F7BD-cylCsE",
        blue_team: fla,
        red_team: kbm
      },
      {
        match_url: "JLTkm1EodyY",
        blue_team: kbm,
        red_team: fla
      },
      {
        match_url: "Xh_z3BogKDA",
        blue_team: fla,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,5,19),
    stage: promotion,
    tournament: cblol_2020_1.id,
    cast_url: "hZitcwYFJqw",
    matches: [
      {
        match_url: "8ERvIgBMP4A",
        blue_team: itz,
        red_team: one
      },
      {
        match_url: "5R1MRC5ojyE",
        blue_team: one,
        red_team: itz
      },
      {
        match_url: "fEaZkARBLYk",
        blue_team: itz,
        red_team: one
      },
      {
        match_url: "bc6Aq2i9KxY",
        blue_team: one,
        red_team: itz
      },
      {
        match_url: "PMT1fpTJVyg",
        blue_team: one,
        red_team: itz
      }
    ]
  }
]
# calling method for s2020 - split 1
puts "calling method for s2020 - split 1"
seed_db(s2020_1)

s2020_2 = [
  {
    date: Date.new(2020,6,6),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "VYqYL8V2lD8",
    matches: [
      {
        match_url: "jNSLy9HobVw",
        blue_team: png,
        red_team: fla
      },
      {
        match_url: "r-z2f3kz0O0",
        blue_team: fur,
        red_team: itz
      },
      {
        match_url: "dxSoCgBk4wo",
        blue_team: san,
        red_team: vk
      },
      {
        match_url: "KNHb4vYdSiM",
        blue_team: prg,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,6,7),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "UBm5DAEgNII",
    matches: [
      {
        match_url: "BMj2WvCE88s",
        blue_team: fla,
        red_team: itz
      },
      {
        match_url: "zdr_EtvHfXA",
        blue_team: fur,
        red_team: prg
      },
      {
        match_url: "7x3nNgY35HI",
        blue_team: vk,
        red_team: kbm
      },
      {
        match_url: "EWLG0wEvCcQ",
        blue_team: san,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,6,13),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "lyA_iusFGt0",
    matches: [
      {
        match_url: "xP8zqotBt2Q",
        blue_team: vk,
        red_team: prg
      },
      {
        match_url: "1EvLf8mRJAg",
        blue_team: kbm,
        red_team: san
      },
      {
        match_url: "K_2gQGLJomo",
        blue_team: itz,
        red_team: png
      },
      {
        match_url: "HBLf2CmSsis",
        blue_team: fla,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,6,14),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "AwzdJ_O-Ji8",
    matches: [
      {
        match_url: "H1QvwIRGAbk",
        blue_team: itz,
        red_team: san
      },
      {
        match_url: "DRetoRpkhy0",
        blue_team: png,
        red_team: vk
      },
      {
        match_url: "tiOyUHGPUPM",
        blue_team: prg,
        red_team: fla
      },
      {
        match_url: "uWb32bfRce8",
        blue_team: fur,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,6,20),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "QIcgRApgjI4",
    matches: [
      {
        match_url: "JE-TYwLGnsY",
        blue_team: san,
        red_team: fur
      },
      {
        match_url: "8OZanr9XnHY",
        blue_team: fla,
        red_team: vk
      },
      {
        match_url: "wYYSU3uDDe0",
        blue_team: kbm,
        red_team: png
      },
      {
        match_url: "8o_b63e0jtY",
        blue_team: itz,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2020,6,21),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "0yHW9d2qx3g",
    matches: [
      {
        match_url: "VK-jMQg21Tw",
        blue_team: kbm,
        red_team: fla
      },
      {
        match_url: "s8IddRLVnd4",
        blue_team: prg,
        red_team: san
      },
      {
        match_url: "GYh5nc3HayU",
        blue_team: png,
        red_team: fur
      },
      {
        match_url: "xIFHnT7hhr8",
        blue_team: vk,
        red_team: san
      }
    ]
  },
  {
    date: Date.new(2020,6,27),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "YxULWMbQAyg",
    matches: [
      {
        match_url: "lXpUMBAybJ0",
        blue_team: png,
        red_team: prg
      },
      {
        match_url: "AUjUs1zCGDM",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "MKskxKzQV1k",
        blue_team: fla,
        red_team: san
      },
      {
        match_url: "511_WJeUo4g",
        blue_team: fur,
        red_team: vk
      }
    ]
  },
  {
    date: Date.new(2020,6,28),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url:  "nLXM8z7XG7A",
    matches: [
      {
        match_url: "Gkkg0dguej4",
        blue_team: fla,
        red_team: png
      },
      {
        match_url: "PERJHFkxF-U",
        blue_team: vk,
        red_team: san
      },
      {
        match_url: "otOMS4dGaRA",
        blue_team: itz,
        red_team: fur
      },
      {
        match_url: "bieXEGrzqJ4",
        blue_team: kbm,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2020,7,4),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "ZF22BOarorQ",
    matches: [
      {
        match_url: "uW1Re_0xEQQ",
        blue_team: kbm,
        red_team: vk
      },
      {
        match_url: "-EfP5lAuCds",
        blue_team: png,
        red_team: san
      },
      {
        match_url: "0T3PFRnMeWs",
        blue_team: itz,
        red_team: fla
      },
      {
        match_url: "Vo7pIR-3IOI",
        blue_team: prg,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,7,5),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "vVeSguyzXNE",
    matches: [
      {
        match_url: "NzM6smbUPvI",
        blue_team: san,
        red_team: kbm
      },
      {
        match_url: "HBfo971F1j0",
        blue_team: fur,
        red_team: fla
      },
      {
        match_url: "EZ3-oxWI1Gc",
        blue_team: prg,
        red_team: vk
      },
      {
        match_url: "obUdNib0Fsg",
        blue_team: png,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2020,7,11),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "GkiNQdelIkw",
    matches: [
      {
        match_url: "y1DqAaOJRzY",
        blue_team: san,
        red_team: itz
      },
      {
        match_url: "CdfCqkwlVlE",
        blue_team: fla,
        red_team: prg
      },
      {
        match_url: "eLVhxz3sGNY",
        blue_team: kbm,
        red_team: fur
      },
      {
        match_url: "iTjws5kh6JU",
        blue_team: vk,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,7,12),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "yURmesQKeAk",
    matches: [
      {
        match_url: "fHrsA9v7n1A",
        blue_team: prg,
        red_team: itz
      },
      {
        match_url: "8xasChllEj8",
        blue_team: png,
        red_team: kbm
      },
      {
        match_url: "PaDSWvYf6xw",
        blue_team: vk,
        red_team: san
      },
      {
        match_url: "-NpFIhZy-DY",
        blue_team: fur,
        red_team: san
      }
    ]
  },
  {
    date: Date.new(2020,7,18),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "gekVSFUrTfY",
    matches: [
      {
        match_url: "0vrKUU7yXhc",
        blue_team: fur,
        red_team: png
      },
      {
        match_url: "HD5Cny43R1c",
        blue_team: itz,
        red_team: vk
      },
      {
        match_url: "-FOwwBOROVs",
        blue_team: san,
        red_team: prg
      },
      {
        match_url: "KR6jg4X1I3o",
        blue_team: fla,
        red_team: kbm
      }
    ]
  },
  {
    date: Date.new(2020,7,19),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "BUscwechVXU",
    matches: [
      {
        match_url: "JXw0YP3HC2Y",
        blue_team: vk,
        red_team: fur
      },
      {
        match_url: "Q7CD3i6x7kE",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "3yIRsuAz_r4",
        blue_team: san,
        red_team: fla
      },
      {
        match_url: "fUaVLnnLf5U",
        blue_team: prg,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,7,25),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "crEdhjqndB0",
    matches: [
      {
        match_url: "3tzl30bSpZk",
        blue_team: vk,
        red_team: san
      },
      {
        match_url: "ffRSpiD_jEc",
        blue_team: itz,
        red_team: fur
      },
      {
        match_url: "OOgnvCpSGg4",
        blue_team: fla,
        red_team: png
      },
      {
        match_url: "ltthKJTHvM8",
        blue_team: kbm,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2020,7,26),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "qbMTpwgpZ0E",
    matches: [
      {
        match_url: "FpVtCcAMC4o",
        blue_team: png,
        red_team: san
      },
      {
        match_url: "bA5WhFQjiWY",
        blue_team: prg,
        red_team: fur
      },
      {
        match_url: "AR9QVMLIZRk",
        blue_team: vk,
        red_team: kbm
      },
      {
        match_url: "CK_5eL_nr7U",
        blue_team: fla,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2020,8,1),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "Pe8Dc42I4b4",
    matches: [
      {
        match_url: "53VI4kvnYO0",
        blue_team: itz,
        red_team: png
      },
      {
        match_url: "b0Tanxz7ZdU",
        blue_team: kbm,
        red_team: san
      },
      {
        match_url: "YYxk_u04fl8",
        blue_team: fla,
        red_team: fur
      },
      {
        match_url: "uDtZ3nV-4oU",
        blue_team: prg,
        red_team: vk
      }
    ]
  },
  {
    date: Date.new(2020,8,2),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "DcxpvJb6wZo",
    matches: [
      {
        match_url: "Ra8dB9YMfzA",
        blue_team: kbm,
        red_team: fur
      },
      {
        match_url: "yZ7F8Nf1K5c",
        blue_team: prg,
        red_team: fla
      },
      {
        match_url: "GbMj-aXt_ec",
        blue_team: itz,
        red_team: san
      },
      {
        match_url: "2HZJS0MTYOc",
        blue_team: vk,
        red_team: png
      }
    ]
  },
  {
    date: Date.new(2020,8,7),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "yInrbIvVPYE",
    matches: [
      {
        match_url: "ATNhXoYiF9U",
        blue_team: prg,
        red_team: itz
      },
      {
        match_url: "plW8SZ-Bbkk",
        blue_team: kbm,
        red_team: png
      },
      {
        match_url: "9jBJKkLsAJA",
        blue_team: fla,
        red_team: vk
      },
      {
        match_url: "iC5ycdSzmlI",
        blue_team: san,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,8,8),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "voOlv-B-Q9Y",
    matches: [
      {
        match_url: "Rf4eM8-MS0M",
        blue_team: kbm,
        red_team: fla
      },
      {
        match_url: "XzzX_RlnWas",
        blue_team: itz,
        red_team: vk
      },
      {
        match_url: "PuJdvH94xbE",
        blue_team: prg,
        red_team: san
      },
      {
        match_url: "bkxZhDOwKOo",
        blue_team: png,
        red_team: fur
      }
    ]
  },
  {
    date: Date.new(2020,8,9),
    stage: points,
    tournament: cblol_2020_2.id,
    cast_url: "fz_4tSiYDvU",
    matches: [
      {
        match_url: "-W_CW3ve9-Q",
        blue_team: vk,
        red_team: fur
      },
      {
        match_url: "_VRLnDDpqs0",
        blue_team: png,
        red_team: prg
      },
      {
        match_url: "KdTy45LXNRk",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "0UM88-BaDZU",
        blue_team: san,
        red_team: fla
      }
    ]
  },
  {
    date: Date.new(2020,8,22),
    stage: playoffs,
    tournament: cblol_2020_2.id,
    cast_url: "ojuYAskQZbY",
    matches: [
      {
        match_url: "sDSmjkUWk38",
        blue_team: png,
        red_team: prg
      },
      {
        match_url: "WZCiHJkD8Rw",
        blue_team: png,
        red_team: prg
      },
      {
        match_url: "eoLBIVGHwKk",
        blue_team: png,
        red_team: prg
      },
      {
        match_url: "mIWKQd6YATQ",
        blue_team: prg,
        red_team: png
      },
      {
        match_url: "eUdAsOgDisw",
        blue_team: png,
        red_team: prg
      }
    ]
  },
  {
    date: Date.new(2020,8,23),
    stage: playoffs,
    tournament: cblol_2020_2.id,
    cast_url:  "2tr1pl4GQcA",
    matches: [
      {
        match_url: "zFyK4I-4j08",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "tCkEWWC5DBU",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "PGBhg6zhiGg",
        blue_team: itz,
        red_team: kbm
      },
      {
        match_url: "r7xv8sIW4vo",
        blue_team: kbm,
        red_team: itz
      },
      {
        match_url: "sNofR5WrMdA",
        blue_team: kbm,
        red_team: itz
      }
    ]
  },
  {
    date: Date.new(2020,9,5),
    stage: playoffs,
    tournament: cblol_2020_2.id,
    cast_url: "OhBXywBd7Ac",
    matches: [
      {
        match_url: "eNmbb7NLZ3U",
        blue_team: png,
        red_team: itz
      },
      {
        match_url: "pxNuaNR-Q4s",
        blue_team: itz,
        red_team: png
      },
      {
        match_url: "dB0aOUPwFxU",
        blue_team: itz,
        red_team: png
      },
      {
        match_url: "VciaGrifb4A",
        blue_team: png,
        red_team: itz
      }
    ]
  }
]
# calling method for s2020 - split 2
puts "calling method for s2020 - split 2"
seed_db(s2020_2)
