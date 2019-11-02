
Club.destroy_all
c1 = Club.create :short_sign=> 'MAC', :name=> 'Macquarie Uni SC', :website=> "http://facebook.com/macunisoccer"
c2 = Club.create :short_sign=> 'MCS', :name=> 'Macquarie Dragons FC', :website=> "http://www.macquariedragons.com.au/website/"
c3 = Club.create :short_sign=> 'WRR', :name=> 'West Ryde Rovers FC'
c4 = Club.create :short_sign=> 'OIS', :name=> 'Old Ignatians FC'
c5 = Club.create :short_sign=> 'NRS', :name=> 'North Ryde SC'
c6 = Club.create :short_sign=> 'RDP', :name=> 'Ryde Panthers FC'
c7 = Club.create :short_sign=> 'GLS', :name=> 'Gladesville Sharks FC'
c8 = Club.create :short_sign=> 'ASH', :name=> 'All Saints Hunters Hill FC'
c9 = Club.create :short_sign=> 'EPP', :name=> 'Epping FC'
c10 = Club.create :short_sign=> 'LEA', :name=> 'Roselea FC'
c11 = Club.create :short_sign=> 'WRE', :name=> 'West Ryde Eagles SC'
c12 = Club.create :short_sign=> 'WRE', :name=> 'West Ryde Eagles SC'
c13 = Club.create :short_sign=> 'RED', :name=> 'Redbacks FC'
c14 = Club.create :short_sign=> 'HCC', :name=> 'Holy Cross College SC'
c15 = Club.create :short_sign=> 'WPH', :name=> 'WPH Cherrybrook FC'
c16 = Club.create :short_sign=> 'RAV', :name=> 'Gladesville Ravens SC'
c17 = Club.create :short_sign=> 'THL', :name=> 'Thornleigh FC'
c18 = Club.create :short_sign=> 'NMH', :name=> 'Normanhurst FC'
c19 = Club.create :short_sign=> 'EEW', :name=> 'Epping Eastwood FC'
c20 = Club.create :short_sign=> 'PUT', :name=> 'Pennant Hills FC'
c21 = Club.create :short_sign=> 'PEN', :name=> 'Epping Eastwood FC'
c22 = Club.create :short_sign=> 'STA', :name=> 'Eastwood St Andrews AFC'
c23 = Club.create :short_sign=> 'NER', :name=> 'North Epping Rangers SC'
c24 = Club.create :short_sign=> 'BEE', :name=> 'Beecroft FC'
c25 = Club.create :short_sign=> 'HWK', :name=> 'Hills Hawks FC'
# c26 = Club.create :short_sign=> 'BYE', :name=> '~~BYE~~' #TODO: how to deal with byes better? This is how it was done in the existing system
c27 = Club.create :short_sign=> 'ARA', :name=> 'Ararat FC'
c28 = Club.create :short_sign=> 'NHF', :name=> 'Northern HFC'
c29 = Club.create :short_sign=> 'PFC', :name=> 'Putney FC'
c30 = Club.create :short_sign=> 'RFL', :name=> 'Redfield Lions'
c31 = Club.create :short_sign=> 'STU', :name=> 'Ryde Saints Utd FC'
c32 = Club.create :short_sign=> 'STP', :name=> 'St Patricks FC'
puts "created #{Club.count} clubs"

Ground.destroy_all
g1 = Ground.create :short_sign=> 'ARCAD', :name=> "Arcadia Park", :latitude=> -33.617426, :longitude=> 151.057809
g2 = Ground.create :short_sign=> 'CP', :name=> "Christie Park", :latitude=> -33.771386, :longitude=> 151.118809
g3 = Ground.create :short_sign=> 'JAMES', :name=> "James Henty Drive Oval", :latitude=> -33.711862, :longitude=> 151.030346
g4 = Ground.create :short_sign=> 'BILLM', :name=> "Bill Mitchell Park", :latitude=> -33.831950, :longitude=> 151.119360
g5 = Ground.create :short_sign=> 'CARL', :name=> "Carlingford Oval", :latitude=> -33.764173, :longitude=> 151.049980
g6 = Ground.create :short_sign=> 'RIVER', :name=> "Riverglad Reserve", :latitude=> -33.837167, :longitude=> 151.139933
g7 = Ground.create :short_sign=> 'TYAG', :name=> "Tyagarah Park", :latitude=> -33.823708, :longitude=> 151.115044
puts "created #{Ground.count} grounds"

def generate_matchups(team_ids)
  # |_1_| 2 3 4 5  | 1 stays in place, 2 => 5 => 10 => 6 => 2 rotate clockwise. matchup is vertical pairs
  # | 6   7 8 9 10 |
  team_ids << 0 if team_ids.size.odd? # add bye (0 placeholder) if odd no. of teams in array
  len = team_ids.size
  top_row = team_ids.take(len/2)
  first = top_row.shift
  bottom_row = team_ids.drop(len/2)

  matchups = []
  (len * 2 - 2).times do |r| #draw generation algo (hardcoded for 10 team comp)
    round = []
    r.odd? ? round << [first, bottom_row.first] : round << [bottom_row.first, first]
    (0..top_row.size - 1).each do |i|
      r.even? ? round << [top_row[i], bottom_row[i + 1]] : round << [bottom_row[i + 1], top_row[i]]
    end
    matchups << round
    bottom_row << top_row.pop
    top_row.unshift bottom_row.shift
  end
  matchups
end

def generate_random_data(age_group, division, team_count=10, start_date="2019-03-30")
  identifiers = %w(Red Blue Green Yellow Wombats Possums Kangas Slugs Kittens Cats Cats Pink Lilac)
  these_teams = [] #array containing ids
  team_count.times do |i|
    used_clubs = Team.where(:division=> division, :age_group => age_group).map {|t| t.club}
    t = Team.create :division=> division, :age_group => age_group
    t.identifier = identifiers.sample if rand(4) == 2
    c = Club.order("RANDOM()").first
    while used_clubs.include? c
      c = Club.order("RANDOM()").first
    end
    c.teams << t
    these_teams << t.id
  end

  times = ["11:00:00.000", "13:00:00.000", "15:00:00.000", "17:00:00.000"]
  matchups = generate_matchups(these_teams)
  (team_count * 2 - 2).times do |i|
    (team_count/2).times do |j|
      m = Match.create(:round=> "#{i + 1}", :game_date=> "#{Date.parse(start_date) + 7 * i + rand(2)} #{times.sample}", :age_group=> age_group, :division=> division)
      m.home_id = matchups[i][j][0]
      m.away_id = matchups[i][j][1]
      m.home_score = rand(6) if m.game_date < Time.now
      m.away_score = rand(6) if m.game_date < Time.now
      Ground.order("RANDOM()").first.matches << m
      m.save
    end
  end
  # binding.pry

end

User.destroy_all
u1 = User.create :email=> "jez.milledge@gmail.com", :name=> "Jeremy Milledge", :password => 'chicken', :admin=> true
u2 = User.create :email=> "jt@ga.co", :name=> "JT", :password => 'chicken', :admin=> false
puts "created #{User.count} users"

Team.destroy_all
Match.destroy_all
generate_random_data('O35', '3')
generate_random_data('U21', '2', 12, "2019-08-17")
generate_random_data('SL', '1', 12, "2019-07-27")
generate_random_data('SL', '2', 12, "2019-07-27")
generate_random_data('AA', '3', 10, "2019-09-28")
generate_random_data('AA', '4', 10, "2019-09-28")

puts "created #{Team.count} teams"
puts "created #{Match.count} matches"

Team.first.users << u1
Team.last.users << u2
Team.order("RANDOM()").first.users << u1 << u2
Team.order("RANDOM()").first.users << u1
Team.order("RANDOM()").first.users << u2
