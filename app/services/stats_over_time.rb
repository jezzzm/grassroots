class StatsOverTime < ApplicationService
  def initialize matches, min_round: 1, max_round: nil, specific_round: nil
    @matches = matches
    @start = min_round
    @end = max_round
    @specific = specific_round
  end

  #call StatParser match by match
  #assign results to obj with key: round # and vals: match stats
  #create and sort ladders round by round

  def call stat
    data = Hash.new { |h, k| h[k] = {} }
    @matches.each do |m|
      teams = [m.home_team, m.away_team]
      scaffs = StatScaffold.call(teams)
      scaffs[m.home_id], scaffs[m.away_id] = StatParser.call(m, scaffs[m.home_id], scaffs[m.away_id])
      data[m.home_team.name][m.round] = scaffs[m.home_id][stat]
      data[m.away_team.name][m.round] = scaffs[m.away_id][stat]
    end
    data.map {|team| {:name => team[0], :data => team[1]}}
  end
end
