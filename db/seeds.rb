
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
u1 = User.create :email=> "jez.milledge@gmail.com", :name=> "Jeremy Milledge"
u2 = User.create :email=> "jt@ga.co", :name=> "JT"
puts "created #{User.count} users"
