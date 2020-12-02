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

    cast_response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=#{hash[:cast_url]}&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics&maxResults=100")
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
    hash[:matches].each do |match|
      match_response = HTTParty.get("https://youtube.googleapis.com/youtube/v3/videos?id=#{match[:match_url]}&key=#{ENV['YOUTUBE_KEY']}&part=snippet, contentDetails, statistics&maxResults=100")
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
