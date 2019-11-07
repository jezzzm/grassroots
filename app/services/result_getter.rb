class ResultGetter < ApplicationService
  def initialize match_id, current_team_id
    @match = Match.find match_id
    @current = current_team_id
  end

  def call
    if @match.home_score == @match.away_score
      return 'D'
    elsif @match.home_id == @current
      return 'W' if @match.home_score > @match.away_score
      return 'L' if @match.home_score < @match.away_score
    else
      return 'W' if @match.home_score < @match.away_score
      return 'L' if @match.home_score > @match.away_score
    end
  end
end
