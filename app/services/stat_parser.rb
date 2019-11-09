class StatParser < ApplicationService
  def initialize match, home_scaffold, away_scaffold
    @match = match
    @home = home_scaffold
    @away = away_scaffold
  end

  def call
    if @match.home_score == @match.away_score #draw
      @home[:d] += 1
      @home[:pts] += 1
      @away[:d] += 1
      @away[:pts] += 1

    elsif @match.home_score > @match.away_score #home win
      @home[:w] += 1
      @home[:pts] += 3
      @away[:l] += 1

    else #away win
      @home[:l] += 1
      @away[:w] += 1
      @away[:pts] += 3
    end

    @home[:mp] += 1
    @home[:gf] += @match.home_score
    @home[:ga] += @match.away_score
    @home[:gd] = @home[:gf] - @home[:ga]
    @away[:mp] += 1
    @away[:gf] += @match.away_score
    @away[:ga] += @match.home_score
    @away[:gd] = @away[:gf] - @away[:ga]

    @home[:cs] += 1 if @match.away_score == 0
    @away[:cs] += 1 if @match.home_score == 0

    @home[:rd] = @match.round
    @away[:rd] = @match.round

    [@home, @away]
  end
end
