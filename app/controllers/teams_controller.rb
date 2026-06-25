class TeamsController < ApplicationController
  def index
    @teams = LeagueTableService.ordered_teams
  end

  def show
    @team = LeagueTableService.find_team(params[:id])

    redirect_to teams_path unless @team
  end
end
