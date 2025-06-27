class TeamsController < ApplicationController
  def index
    @teams = EspnApiService.fetch_teams

    # Sort teams by league position (position 1 = first place)
    @teams = @teams.sort_by { |team| team.position || Float::INFINITY }
  end

  def show
    @teams = EspnApiService.fetch_teams
    @team = @teams.find { |team| team.espn_id == params[:id] }

    redirect_to teams_path unless @team
  end
end
