module PagesHelper

  #build ladder for division
  def get_ladder(age_group, division, abridged=nil) #abridged will include only self +/-1 teams
    ladder = LadderCreator.call(Match.age_group(age_group).division(division).results)
    # raise 'hell'
    if abridged.blank?
      ladder
    else #do filtering for abridged = team_id
      this_team = ladder.index(ladder.detect.each_with_index {|pos, i| pos[i][0] == abridged })
      ladder.select.each_with_index do |team, i|
        (i.between?(this_team - 1, this_team + 1) && i.between?(0, ladder.size - 1))
      end
    end
  end

end
