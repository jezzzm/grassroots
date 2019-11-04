module TeamHelper
  def get_teams_in_comp(age_group, division)
    teams = Team.where(:age_group => age_group, :division => division)
  end

  def team_classes(team_id, home=false)
    classes = ""
    classes << "page-team " if params[:id].present? && params[:id].to_i == team_id
    classes << "fav-team " if @current_user.present? && @current_user.teams.pluck(:id).include?(team_id)
    classes << "home-team " if home
    # raise 'hell'
    return classes
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
