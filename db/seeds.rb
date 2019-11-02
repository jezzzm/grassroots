
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
c26 = Club.create :short_sign=> 'BYE', :name=> '~~BYE~~' #TODO: how to deal with byes better? This is how it was done in the existing system
c27 = Club.create :short_sign=> 'ARA', :name=> 'Ararat FC'
c28 = Club.create :short_sign=> 'NHF', :name=> 'Northern HFC'
c29 = Club.create :short_sign=> 'PFC', :name=> 'Putney FC'
c30 = Club.create :short_sign=> 'RFL', :name=> 'Redfield Lions'
c31 = Club.create :short_sign=> 'STU', :name=> 'Ryde Saints Utd FC'
c32 = Club.create :short_sign=> 'STP', :name=> 'St Patricks FC'
puts "created #{Club.count} clubs"


User.destroy_all
u1 = User.create :email=> "jez.milledge@gmail.com", :name=> "Jeremy Milledge", :password => 'chicken', :admin=> true
u2 = User.create :email=> "jt@ga.co", :name=> "JT", :password => 'chicken', :admin=> false
puts "created #{User.count} users"

Team.destroy_all
t1 = Team.create :division=> "1", :age_group=> 'AA', :identifier=> 'Blue'
t2 = Team.create :division=> "1", :age_group=> 'AA'
t3 = Team.create :division=> "1", :age_group=> 'AA'

t4 = Team.create :division=> "1", :age_group=> 'SL', :identifier=> 'Possums'
t5 = Team.create :division=> "1", :age_group=> 'SL'
t6 = Team.create :division=> "1", :age_group=> 'SL'
puts "created #{Team.count} teams"

Ground.destroy_all
g1 = Ground.create :short_sign=> 'ARCAD', :name=> "Arcadia Park", :latitude=> -33.617426, :longitude=> 151.057809
g2 = Ground.create :short_sign=> 'CP', :name=> "Christie Park", :latitude=> -33.771386, :longitude=> 151.118809
g3 = Ground.create :short_sign=> 'JAMES', :name=> "James Henty Drive Oval", :latitude=> -33.711862, :longitude=> 151.030346
puts "created #{Ground.count} grounds"

Match.destroy_all
m1 = Match.create! :round=> 1, :game_date=> "2019-04-13 00:00:00.000", :age_group=> 'AA', :division=> '1', :home_score=> 3, :away_score=> 2
m2 = Match.create! :round=> 1, :game_date=> "2019-04-13 00:00:00.000", :age_group=> 'AA', :division=> '1', :home_score=> 0, :away_score=> 1
m3 = Match.create! :round=> 2, :game_date=> "2019-06-15 00:00:00.000", :age_group=> 'AA', :division=> '1', :home_score=> 1, :away_score=> 5

m4 = Match.create! :round=> 12, :game_date=> "2019-12-14 13:00:00.000", :age_group=> 'SL', :division=> '1'
m5 = Match.create! :round=> 12, :game_date=> "2019-12-14 17:00:00.000", :age_group=> 'SL', :division=> '1'
m6 = Match.create! :round=> 12, :game_date=> "2019-12-15 15:00:00.000", :age_group=> 'SL', :division=> '1'

m7 = Match.create! :round=> 12, :game_date=> "2019-12-31 11:00:00.000", :age_group=> 'AA', :division=> '1'
m8 = Match.create! :round=> 12, :game_date=> "2019-12-31 13:00:00.000", :age_group=> 'AA', :division=> '1'
m9 = Match.create! :round=> 12, :game_date=> "2019-12-31 15:00:00.000", :age_group=> 'AA', :division=> '1'


puts "created #{Match.count} matches"

#ASSOCIATIONS
c2.teams << t1
c21.teams << t2
c5.teams << t3

c6.teams << t4
c9.teams << t5
c28.teams << t6
puts "associated teams to clubs"

g1.matches << m1 << m4 << m7
g2.matches << m2 << m5 << m8
g3.matches << m3 << m6 << m9
puts "associated matches to grounds"

t1.users << u1
t2.users << u1
t3.users << u1 << u2

t4.users << u1
t5.users << u1
t6.users << u2 << u1
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

m4.home_id = t4.id
m4.away_id = t5.id
m4.save
m5.home_id = t5.id
m5.away_id = t6.id
m5.save
m6.home_id = t6.id
m6.away_id = t4.id
m6.save

m7.home_id = t2.id
m7.away_id = t1.id
m7.save
m8.home_id = t3.id
m8.away_id = t2.id
m8.save
m9.home_id = t1.id
m9.away_id = t3.id
m9.save
puts "associated home and away teams to matches"
