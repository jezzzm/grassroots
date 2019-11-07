class LadderSorter < ApplicationService

  def initialize populated_scaffolds
    @team_scaffolds = populated_scaffolds
  end

  def call #https://codereview.stackexchange.com/questions/52062/a-ruby-sorting-program-for-multiple-criteria
    sorted = @team_scaffolds.sort_by do |id, team|
      [
        team[:pts]*-1,  # first by points
        team[:gd]*-1,   # then by goal diff
        team[:gf]*-1,   # then by goals for
        team[:gc]       # then by fewest goals conceded
      ]
    end

    #assign key as table position
    sorted.map.each_with_index {|t, i| {i=> t} }
  end
end
