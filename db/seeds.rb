
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
c15 = Club.create :short_sign=> 'WPH', :name=> 'West Pennant Hills Cherrybrook Football Club'
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
c26 = Club.create :short_sign=> 'BYE', :name=> '~~BYE~~'
c27 = Club.create :short_sign=> 'ARA', :name=> 'Ararat FC'
c28 = Club.create :short_sign=> 'NHF', :name=> 'Northern HFC'
c29 = Club.create :short_sign=> 'PFC', :name=> 'Putney FC'
c30 = Club.create :short_sign=> 'RFL', :name=> 'Redfield Lions'
c31 = Club.create :short_sign=> 'STU', :name=> 'Ryde Saints Utd FC'
c32 = Club.create :short_sign=> 'STP', :name=> 'St Patricks FC'
puts "created #{Club.count} clubs"


User.destroy_all
u1 = User.create :email=> "jez.milledge@gmail.com", :name=> "Jeremy Milledge", :admin=> true
u2 = User.create :email=> "jt@ga.co", :name=> "JT", :admin=> false
puts "created #{User.count} users"

Team.destroy_all
t1 = Team.create :division=> "3", :age_group=> 'AA'
t2 = Team.create :division=> "2", :age_group=> 'O35'
t3 = Team.create :division=> "1", :age_group=> 'SL'
puts "created #{Team.count} teams"

Ground.destroy_all
g1 = Ground.create :short_sign=> 'ARCAD', :name=> "Arcadia Park", :latitude=> -33.617426, :longitude=> 151.057809
g2 = Ground.create :short_sign=> 'CP', :name=> "Christie Park", :latitude=> -33.771386, :longitude=> 151.118809
g3 = Ground.create :short_sign=> 'JAMES', :name=> "James Henty Drive Oval", :latitude=> -33.711862, :longitude=> 151.030346
puts "created #{Ground.count} grounds"

Match.destroy_all
m1 = Match.create! :round=> 1, :game_date=> "2019-04-13 00:00:00.000", :home_score=> 3, :away_score=> 2
m2 = Match.create! :round=> 1, :game_date=> "2019-04-13 00:00:00.000", :home_score=> 0, :away_score=> 0
m3 = Match.create! :round=> 5, :game_date=> "2019-06-15 00:00:00.000", :home_score=> 1, :away_score=> 5
puts "created #{Match.count} matches"

#ASSOCIATIONS
c2.teams << t1
c21.teams << t2
c5.teams << t3
puts "associated teams to clubs"

g1.matches << m1
g2.matches << m2
g3.matches << m3
puts "associated matches to grounds"

t1.users << u1
t2.users << u1
t3.users << u1 << u2
puts "associated m:n users and favourite teams"

m1.home_id = t1.id
m1.away_id = t2.id
m1.save
m2.home_id = t2.id
m2.away_id = t3.id
m2.save
m3.home_id = t3.id
m3.away_id = t1.id
m3.save
puts "associated home and away teams to matches"
