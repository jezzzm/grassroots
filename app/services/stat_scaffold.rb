class StatScaffold < ApplicationService
  def initialize teams_collection
    @teams = teams_collection
  end

  def call #new hash with team_ids as keys, values are hash with keys set to zero
    Hash[ @teams.collect { |t|
      [t.id, {
        :name=> t.name,
        :mp => 0, #matches played
        :w => 0, #wins
        :d => 0, #draws
        :l => 0, #losses
        :gf => 0, #goals for
        :ga => 0, #goals against
        :gd => 0, #goal difference
        :pts => 0, #points (3 for win, 1 for draw, 0 for loss)
        :cs => 0 #clean sheets
      }]
    }]
  end
end
