
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
c13 = Club.create :short_sign=> 'RED', :name=> 'Redbacks FC'
c14 = Club.create :short_sign=> 'HCC', :name=> 'Holy Cross College SC'
c15 = Club.create :short_sign=> 'WPH', :name=> 'WPH Cherrybrook FC'
c16 = Club.create :short_sign=> 'RAV', :name=> 'Gladesville Ravens SC'
c17 = Club.create :short_sign=> 'THL', :name=> 'Thornleigh FC'
c18 = Club.create :short_sign=> 'NMH', :name=> 'Normanhurst FC'
c19 = Club.create :short_sign=> 'EEW', :name=> 'Epping Eastwood FC'
c20 = Club.create :short_sign=> 'PUT', :name=> 'Putney United FC'
c21 = Club.create :short_sign=> 'PEN', :name=> 'Pennant Hills FC'
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
g6 = Ground.create :short_sign=> 'RIVER', :name=> "Riverglade Reserve", :latitude=> -33.837167, :longitude=> 151.139933
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
  (len * 2 - 2).times do |r|
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

def generate_random_data(age_group, division, team_count=10, start_date="2018-09-28")
  identifiers = %w(Red Blue Green Yellow Wombats Wombats Possums Kangas Slugs Kittens Cats Cats Cats Pink Lilac)
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
  lorems = [
    "I got your invoice...it seems really high, why did you charge so much im not sure, try something else I want you to take it to the next level, for im not sure, try something else. Doing some work for us 'pro bono' will really add to your portfolio i promise I have an awesome idea for a startup, i need you to build it for me make it pop nor you can get my logo from facebook or can you use a high definition screenshot thanks for taking the time to make the website, but i already made it in wix. Could you solutionize that for me remember, everything is the same or better for i'll know it when i see it for this turned out different that i decscribed nor doing some work for us 'pro bono' will really add to your portfolio i promise it needs to be the same, but totally different will royalties in the company do instead of cash. Can you pimp this powerpoint, need more geometry patterns. Can you lower the price for the website? make it high quality and please use html can you make the font a bit bigger and change it to times new roman? jazz it up a little bit make the picture of the cupcake look delicious make the purple more well, purple-er it looks so empty add some more hearts can you add a bit of pastel pink and baby blue because the purple alone looks too fancy okay can you put a cute quote on the right side of the site? oh no it looks messed up! i think we need to start from scratch it looks a bit empty, try to make everything bigger, im not sure, try something else, but jazz it up a little. The flier should feel like a warm handshake the flier should feel like a warm handshake i'll pay you in a week we don't need to pay upfront i hope you understand you can get my logo from facebook, and other agencies charge much lesser mmm, exactly like that, but different is there a way we can make the page feel more introductory without being cheesy. I like it, but can the snow look a little warmer could you do an actual logo instead of a font I got your invoice...it seems really high, why did you charge so much try a more powerful colour it looks a bit empty, try to make everything bigger, and this turned out different that i decscribed so can you lower the price for the website? make it high quality and please use html can you make the font a bit bigger and change it to times new roman? jazz it up a little bit make the picture of the cupcake look delicious make the purple more well, purple-er it looks so empty add some more hearts can you add a bit of pastel pink and baby blue because the purple alone looks too fancy okay can you put a cute quote on the right side of the site? oh no it looks messed up! i think we need to start from scratch. This red is too red do less with more, for you are lucky to even be doing this for us.",
    "Can the black be darker make the font bigger or can you make it stand out more?. Can you make it faster?. This turned out different that i decscribed try a more powerful colour mmm, exactly like that, but different or you might wanna give it another shot. Can the black be darker I got your invoice...it seems really high, why did you charge so much, or I really think this could go viral, so this red is too red and we are a startup. I know you've made thirty iterations but can we go back to the first one that was the best version. I want you to take it to the next level labrador this was not according to brief low resolution? It looks ok on my screen, and i'll pay you in a week we don't need to pay upfront i hope you understand but we are a non-profit organization. Submit your meaningless business jargon to be used on the site! doing some work for us 'pro bono' will really add to your portfolio i promise so thats not what i saw in my head at all the website doesn't have the theme i was going for yet I want you to take it to the next level doing some work for us 'pro bono' will really add to your portfolio i promise. This looks perfect. Just Photoshop out the dog, add a baby, and make the curtains blue thats not what i saw in my head at all. I got your invoice...it seems really high, why did you charge so much that's great, but can you make it work for ie 2 please mmm, exactly like that, but different but we are a non-profit organization, and I really think this could go viral, or we exceed the clients' expectations. I'll pay you in a week we don't need to pay upfront i hope you understand make it sexy, nor can you make it faster? that's going to be a chunk of change. Can you help me out? you will get a lot of free exposure doing this I really like the colour but can you change it, yet make it pop but could you do an actual logo instead of a font, and there is too much white space. Can you pimp this powerpoint, need more geometry patterns there are more projects lined up charge extra the next time, yet can you lower the price for the website? make it high quality and please use html can you make the font a bit bigger and change it to times new roman? jazz it up a little bit make the picture of the cupcake look delicious make the purple more well, purple-er it looks so empty add some more hearts can you add a bit of pastel pink and baby blue because the purple alone looks too fancy okay can you put a cute quote on the right side of the site? oh no it looks messed up! i think we need to start from scratch or i love it, but can you invert all colors? nor can't you just take a picture from the internet?. Can you make it stand out more? i'll pay you in a week we don't need to pay upfront i hope you understand and theres all this spanish text on my site yet needs to be sleeker theres all this spanish text on my site, make the font bigger so can you turn it around in photoshop so we can see more of the front. Make it pop it needs to be the same, but totally different can you make it look more designed for i cant pay you . Make it pop i'll know it when i see it can we barter services? we are a startup i'll know it when i see it nor what is a hamburger menu. Do less with more in an ideal world is there a way we can make the page feel more introductory without being cheesy. Can you punch up the fun level on these icons. Make it pop i'll know it when i see it try a more powerful colour you might wanna give it another shot, or can you please send me the design specs again? for it needs to be the same, but totally different we have big contacts we will promote you. It needs to be the same, but totally different it needs to be the same, but totally different nor doing some work for us 'pro bono' will really add to your portfolio i promise and I like it, but can the snow look a little warmer, nor try making it a bit less blah is there a way we can make the page feel more introductory without being cheesy. That's great, but can you make it work for ie 2 please this is just a 5 minutes job, yet i'll know it when i see it mmm, exactly like that, but different so what you've given us is texty, we want sexy low resolution? It looks ok on my screen I need a website. How much will it cost. Can you make the logo bigger yes bigger bigger still the logo is too big you can get my logo from facebook nor can you make it faster?, but we have big contacts we will promote you, nor mmm, exactly like that, but different that sandwich needs to be more playful try making it a bit less blah. There is too much white space there is too much white space but can you make it more infographic-y we need to make the new version clean and sexy yet can you make it look more designed that's going to be a chunk of change or that's going to be a chunk of change.", "Start on it today and we will talk about what i want next time that's great, but can you make it work for ie 2 please, make it sexy, nor what is a hamburger menu i love it, but can you invert all colors? but can you please send me the design specs again? so we don't need a contract, do we. Can you make the blue bluer?. Are you busy this weekend? I have a new project with a tight deadline can you put 'find us on facebook' by the facebook logo? for could you do an actual logo instead of a font. Make it pop can my website be in english? for we exceed the clients' expectations nor can you punch up the fun level on these icons. Can you make it pop theres all this spanish text on my site i love it, but can you invert all colors? can you lower the price for the website? make it high quality and please use html can you make the font a bit bigger and change it to times new roman? jazz it up a little bit make the picture of the cupcake look delicious make the purple more well, purple-er it looks so empty add some more hearts can you add a bit of pastel pink and baby blue because the purple alone looks too fancy okay can you put a cute quote on the right side of the site? oh no it looks messed up! i think we need to start from scratch this turned out different that i decscribed. Doing some work for us 'pro bono' will really add to your portfolio i promise could you rotate the picture to show the other side of the room?. I want you to take it to the next level try making it a bit less blah. Can you put 'find us on facebook' by the facebook logo? do less with more, what you've given us is texty, we want sexy for can you make it stand out more?. This red is too red. I was wondering if my cat could be placed over the logo in the flyer it's great, can you add a beard though we are your relatives can you please change the color theme of the website to pink and purple? make the logo a bit smaller because the logo is too big can you link the icons to my social media accounts? oh and please put pictures of cats everywhere. We need to make the new version clean and sexy start on it today and we will talk about what i want next time you are lucky to even be doing this for us for can you make the logo bigger yes bigger bigger still the logo is too big but this looks perfect. Just Photoshop out the dog, add a baby, and make the curtains blue, for this looks perfect. Just Photoshop out the dog, add a baby, and make the curtains blue. There is too much white space can it be more retro this turned out different that i decscribed this was not according to brief, and low resolution? It looks ok on my screen can you rework to make the pizza look more delicious. What you've given us is texty, we want sexy. Can you make it stand out more? doing some work for us 'pro bono' will really add to your portfolio i promise but can you rework to make the pizza look more delicious, but the flier should feel like a warm handshake. There is too much white space. That's great, but we need to add this 2000 line essay make it look like Apple, for low resolution? It looks ok on my screen, I have printed it out, but the animated gif is not moving. Can you make pink a little more pinkish. I'll pay you in a week we don't need to pay upfront i hope you understand other agencies charge much lesser, nor the website doesn't have the theme i was going for yet can you make the font bigger?, for we exceed the clients' expectations try making it a bit less blah. Something summery; colourful thanks for taking the time to make the website, but i already made it in wix the hair is just too polarising, and that will be a conversation piece, can you use a high definition screenshot. There is too much white space I got your invoice...it seems really high, why did you charge so much, and can you make the logo bigger yes bigger bigger still the logo is too big. Start on it today and we will talk about what i want next time . Can you make it faster? can we barter services?, but theres all this spanish text on my site but that will be a conversation piece. Make the font bigger start on it today and we will talk about what i want next time and can you help me out? you will get a lot of free exposure doing this, for we need to make the new version clean and sexy or do less with more. Im not sure, try something else can it be more retro I like it, but can the snow look a little warmer, and we have big contacts we will promote you is this the best we can do concept is bang on, but can we look at a better execution give us a complimentary logo along with the website. We are your relatives.",
    "Now that we know who you are, I know who I am. I'm not a mistake! It all makes sense! In a comic, you know how you can tell who the arch-villain's going to be? He's the exact opposite of the hero. And most times they're friends, like you and me! I should've known way back when... You know why, David? Because of the kids. They called me Mr Glass.",
    "You think water moves fast? You should see ice. It moves like it has a mind. Like it knows it killed the world once and got a taste for murder. After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. Nature is lethal but it doesn't hold a candle to man.",
    "Your bones don't break, mine do. That's clear. Your cells react to bacteria and viruses differently than mine. You don't get sick, I do. That's also clear. But for some reason, you and I react the exact same way to water. We swallow it too fast, we choke. We get some in our lungs, we drown. However unreal it may seem, we are connected, you and I. We're on the same curve, just on opposite ends.",
    "Skate ipsum dolor sit amet, nosebone gap pop shove-it Andrew Reynolds body varial hanger cab flip gnar bucket. Nollie aerial regular footed rocket air Christ air Alan Gelfand impossible slappy. 1080 nollie boardslide roll-in Memory Screen frigid air chicken wing nose slide. Switch rails hang ten 360 half-cab Neil Blender street hand rail. Rector baseplate nose judo air poseur flail rails shinner. Dude Mike Taylor griptape baseplate downhill kickflip hospital flip kingpin. Dude hurricane hard flip bigspin half-cab disaster Tim May slappy. Launch ramp masonite speed wobbles frontside drop in acid drop Japan air. Ho-ho pump casper aerial rails Kevin Harris impossible. Masonite flypaper wheels ollie hole no comply nosepicker nose bump. Hardware durometer rad Dustin Dollin bank judo air melancholy air. Ledge dude smith grind rad Bunson over the Junson transition pressure flip salad grind.",
    "Skate ipsum dolor sit amet, feeble nose wax quarter pipe backside half-flip betty. Opposite footed axle set 270 soul skate gnar bucket nollie layback. Kevin Ancell street axle set smith grind stalefish sick hang ten crail grab. Soul skate no comply axle set freestyle hardware grind hard flip. Alien Workshop tuna-flip body varial judo air airwalk lipslide hand rail cess slide. Berm boneless gap cess slide face plant slap maxwell nollie. Nose grab hanger Wade Speyer regular footed 1080 heel flip wax shoveit. Noseblunt slide rad nose grab death box ollie mini ramp crail slide John Cardiel. Pump yeah quarter pipe finger flip shoveit locals switch. Berm skater hanger egg plant g-turn Bonite carve full pipe. Smith grind frontside air nose slide crailtap kick-nose tailslide kickturn.",
    "Skate ipsum dolor sit amet, grind fastplant Brooklyn Banks manual aerial. Manual Pushead cab flip carve lip. Downhill 900 disaster pressure flip. Cess slide flail Burnside boned out bail. Rail judo air Primo slide Powell Peralta skate or die. 1080 sketchy bearings Christ air. Risers air Johnny Rad crail grab nose blunt. Hip no comply Paul Rodriguez nosegrind nose grab. Powerslide varial bank transfer. Drop in slam risers salad grind Steve Caballero. Full-cab tuna-flip body varial birdie. Mute-air blunt yeah late.",
    "I love cheese, especially melted cheese cheddar. Cheesecake cheese and biscuits everyone loves queso cottage cheese roquefort cauliflower cheese croque monsieur. Smelly cheese the big cheese everyone loves everyone loves airedale halloumi stinking bishop cheese strings. Smelly cheese parmesan fromage monterey jack boursin cut the cheese parmesan caerphilly. Chalk and cheese goat who moved my cheese say cheese hard cheese cheese on toast roquefort cheese triangles. Port-salut halloumi cheeseburger cheeseburger halloumi boursin cheeseburger brie. Cheese slices melted cheese lancashire cheesecake fromage frais melted cheese fromage frais pepper jack. Cheese triangles say cheese cheese on toast cut the cheese cheese slices who moved my cheese parmesan cheese and biscuits. Croque monsieur boursin dolcelatte parmesan rubber cheese red leicester taleggio cheesecake. Brie the big cheese goat cheese slices stilton.",
    "I love cheese, especially cow cream cheese. Camembert de normandie manchego pecorino cheese strings stinking bishop the big cheese queso cream cheese. Stilton hard cheese dolcelatte dolcelatte airedale babybel smelly cheese danish fontina. Cheese triangles bavarian bergkase rubber cheese the big cheese cheddar danish fontina ricotta cheesecake. Rubber cheese cheese strings taleggio babybel brie dolcelatte blue castello everyone loves. Goat stilton cottage cheese pecorino camembert de normandie brie who moved my cheese goat. Stilton cow macaroni cheese airedale ricotta feta red leicester hard cheese. Cheese strings bocconcini paneer gouda who moved my cheese croque monsieur manchego squirty cheese. Parmesan camembert de normandie cheese triangles jarlsberg blue castello cream cheese cheese strings manchego. Babybel edam the big cheese cheddar fondue danish fontina the big cheese bavarian bergkase. Gouda emmental parmesan paneer when the cheese comes out everybody's happy hard cheese manchego.",
    "I love cheese, especially brie cheeseburger. Cream cheese when the cheese comes out everybody's happy bocconcini emmental goat emmental cheese triangles melted cheese. Cheesy feet swiss emmental dolcelatte the big cheese stinking bishop brie st. agur blue cheese. Cream cheese airedale gouda everyone loves fromage frais macaroni cheese pepper jack cauliflower cheese. Bavarian bergkase airedale port-salut airedale jarlsberg cut the cheese stilton edam. Cheese and biscuits airedale boursin babybel cheese triangles cheese slices the big cheese who moved my cheese. Fromage frais edam roquefort cream cheese mozzarella lancashire everyone loves queso. Everyone loves cheesy grin taleggio fromage pecorino roquefort feta fromage frais. Cheese slices cottage cheese cheesecake cheese strings say cheese danish fontina emmental melted cheese. Brie mascarpone melted cheese port-salut."
  ]
  times = ["11:00:00.000", "13:00:00.000", "15:00:00.000", "17:00:00.000"]
  matchups = generate_matchups(these_teams)
  (team_count * 2 - 2).times do |i|
    (team_count/2).times do |j|
      m = Match.create(:round=> "#{i + 1}", :game_date=> "#{Date.parse(start_date) + 7 * i + rand(2)} #{times.sample}", :age_group=> age_group, :division=> division)
      m.home_id = matchups[i][j][0]
      m.away_id = matchups[i][j][1]
      m.home_score = rand(6) if m.game_date < Time.now
      m.away_score = rand(6) if m.game_date < Time.now
      m.comments = lorems.sample
      Ground.order("RANDOM()").first.matches << m
      m.save
    end
  end
  puts("created #{age_group}/#{division} - #{team_count} teams")
  # binding.pry

end

User.destroy_all
u1 = User.create :email=> "jez.milledge@gmail.com", :name=> "Jeremy Milledge", :password => 'chicken', :admin=> true
u2 = User.create :email=> "jt@ga.co", :name=> "JT", :password => 'chicken', :admin=> false
puts "created #{User.count} users"

Team.destroy_all
Match.destroy_all
generate_random_data('O35', '1')
generate_random_data('O35', '2')
generate_random_data('O35', '3')
generate_random_data('U06', '1')
generate_random_data('U06', '2')
generate_random_data('U07', '1')
generate_random_data('U08', '1')
generate_random_data('U08', '2')
generate_random_data('U09', '1')
generate_random_data('U09', '2')
generate_random_data('U09', '3')
generate_random_data('U10', '1')
generate_random_data('U11', '1')
generate_random_data('U12', '1')
generate_random_data('U13', '1')
generate_random_data('U14', '1')
generate_random_data('U15', '1')
generate_random_data('U16', '1')
generate_random_data('U18', '1')
generate_random_data('U18', '2')
generate_random_data('U18', '3')
generate_random_data('U21', '1', 12, "2019-08-17")
generate_random_data('U21', '2', 12, "2019-08-17")
generate_random_data('SL', '1', 12, "2019-08-27")
generate_random_data('SL', '2', 12, "2019-08-27")
generate_random_data('PL', '1', 12, "2019-08-27")
generate_random_data('PL', '2', 12, "2019-08-27")
generate_random_data('AA', '1', 10, "2019-09-28")
generate_random_data('AA', '2', 10, "2019-09-28")
generate_random_data('AA', '3', 10, "2019-09-28")
generate_random_data('AA', '4', 10, "2019-09-28")
generate_random_data('AA', '5', 10, "2019-09-28")
generate_random_data('AA', '6', 10, "2019-09-28")

puts "created #{Team.count} teams"
puts "created #{Match.count} matches"

Team.first.users << u1
Team.last.users << u2
Team.order("RANDOM()").first.users << u1 << u2
Team.order("RANDOM()").first.users << u1
Team.order("RANDOM()").first.users << u2
Team.order("RANDOM()").first.users << u1 << u2
Team.order("RANDOM()").first.users << u1
Team.order("RANDOM()").first.users << u2
