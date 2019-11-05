class LadderCreator < ApplicationService
  def initialize match_collection
    @matches = match_collection
  end

  def call #buld ladder from collection of matches
    teams = TeamExtractor.call(@matches)
    scaffs = StatScaffold.call(teams)
    @matches.each do |m|
      scaffs[m.home_id], scaffs[m.away_id] = StatParser.call(m, scaffs[m.home_id], scaffs[m.away_id])
    end
    LadderSorter.call scaffs
  end
end
