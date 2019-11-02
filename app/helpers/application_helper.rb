module ApplicationHelper

  def get_teams_in_comp(age, division)
    teams = Team.where(:age_group => age, :division => division)
  end

  def get_standings(age, division, round_limit=0) #TODO: use round limit to check change in positions for visual highlighting
    teams = get_teams_in_comp(age, division) #array of ids in specific comp
    teams = Hash[teams.collect { |t| #new hash with team_ids as keys, values are hash with keys set to zero
       [
         t.id, #team_id
         {
          :name=> t.name,
          :mp => 0, #matches played
          :w => 0, #wins
          :d => 0, #draws
          :l => 0, #losses
          :gf => 0, #goals for
          :ga => 0, #goals against
          :gd => 0, #goal difference
          :pts => 0, #points (3 for win, 1 for draw, 0 for loss)
          :form => [] # TODO: form (WLDWL etc)
        }
      ]
    }]

    #parse matches
    matches = Match.where :age_group=> age, :division=> division
    matches.each do |m|
      if m.home_score == m.away_score #draw

        teams[m.home_id][:d] += 1
        teams[m.home_id][:pts] += 1
        teams[m.home_id][:form] << [m.game_date, 'D']

        teams[m.away_id][:d] += 1
        teams[m.away_id][:pts] += 1
        teams[m.away_id][:form] << [m.game_date, 'D']

      elsif m.home_score > m.away_score #home win
        teams[m.home_id][:w] += 1
        teams[m.home_id][:pts] += 3
        teams[m.home_id][:form] << [m.game_date, 'W']

        teams[m.away_id][:l] += 1
        teams[m.away_id][:form] << [m.game_date, 'L']

      else #away win
        teams[m.home_id][:l] += 1
        teams[m.home_id][:form] << [m.game_date, 'L']

        teams[m.away_id][:w] += 1
        teams[m.away_id][:pts] += 3
        teams[m.away_id][:form] << [m.game_date, 'W']
      end

      teams[m.home_id][:mp] += 1
      teams[m.home_id][:gf] += m.home_score
      teams[m.home_id][:ga] += m.away_score
      teams[m.home_id][:gd] = teams[m.home_id][:gf] - teams[m.home_id][:ga]

      teams[m.home_id][:mp] += 1
      teams[m.away_id][:gf] += m.away_score
      teams[m.away_id][:ga] += m.home_score
      teams[m.away_id][:gd] = teams[m.away_id][:gf] - teams[m.away_id][:ga]

    end
    teams.sort_by {|id, team| [team[:pts]*-1, team[:gd]*-1, team[:gf]*-1]} #https://codereview.stackexchange.com/questions/52062/a-ruby-sorting-program-for-multiple-criteria
  end
end
