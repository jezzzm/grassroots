module TeamHelper
  def get_teams_in_comp(age_group, division)
    teams = Team.where(:age_group => age_group, :division => division)
  end

  def team_classes(team_id:, home: false, row_index: nil, total_rows: nil)
    classes = ""
    classes += "page-team " if params[:id].present? && params[:id] == team_id
    # classes += "fav-team " if @current_user.present? && @current_user.teams.include?(team_id)
    # classes += "home-team " if home
    # classes += "compact-last " if row_index.present? && row_index == total_rows - 1
    # classes += "compact-first " if row_index.present? && row_index.zero?
    # raise 'hell'
    classes
  end

  def next_match(team)
    return nil if team.fixtures.empty?
    team.fixtures.first
  end

  def last_match(team)
    return nil if team.results.empty?
    team.results.first
  end
end
