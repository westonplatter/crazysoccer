class TeamsController < ApplicationController
  def index
    @teams = EspnApiService.fetch_teams
    
    # Sort teams by name for now (will change to ranking when we have win/loss data)
    @teams = @teams.sort_by(&:display_name)
  end
  
  def show
    @teams = EspnApiService.fetch_teams
    @team = @teams.find { |team| team.espn_id == params[:id] }
    
    redirect_to teams_path unless @team
  end
end