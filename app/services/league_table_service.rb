# Owns the business rules for presenting the league table:
# how teams are ordered, and how a single team is located.
#
# Knows nothing about HTTP (no params/render/redirect) and composes
# EspnApiService for the underlying data, so it can be reused from a
# job, a console session, or a test without a request.
class LeagueTableService
  class << self
    # Teams ordered by league position (1 = top of the table).
    # Teams without a known position sink to the bottom.
    def ordered_teams
      EspnApiService.fetch_teams.sort_by { |team| team.position || Float::INFINITY }
    end

    # The single team matching the given ESPN id, or nil if it isn't
    # in the current table.
    def find_team(espn_id)
      EspnApiService.fetch_teams.find { |team| team.espn_id == espn_id }
    end
  end
end
