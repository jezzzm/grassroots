class LadderCreator < ApplicationService
  def initialize match_collection
    @matches = match_collection
  end

  def call #build ladder from collection of matches
    teams = TeamExtractor.call(@matches)
    scaffs = StatScaffold.call(teams)
    @matches.each do |m|
      #accumulate results into one set of stats for each team
      scaffs[m.home_id], scaffs[m.away_id] = StatParser.call(m, scaffs[m.home_id], scaffs[m.away_id])
    end
    LadderSorter.call scaffs
  end
end
