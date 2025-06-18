class TeamsController < ApplicationController
  def index
    @teams = EspnApiService.fetch_teams
    
    # Sort teams by name for now (will change to ranking when we have win/loss data)
    @teams = @teams.sort_by(&:display_name)
  end
end