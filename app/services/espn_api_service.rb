require "net/http"
require "json"

class EspnApiService
  BASE_URL = "https://site.api.espn.com/apis/site/v2/sports/soccer".freeze
  PREMIER_LEAGUE = "eng.1".freeze
  CACHE_EXPIRY = 1.hour

  class << self
    def fetch_teams
      Rails.cache.fetch("espn_teams", expires_in: CACHE_EXPIRY) do
        url = "#{BASE_URL}/#{PREMIER_LEAGUE}/teams"
        response = make_request(url)

        return [] unless response
        teams_data = response.dig("sports", 0, "leagues", 0, "teams") || []
        teams_with_standings = teams_data.map do |team_data|
          team_info = team_data["team"]
          ::Domain::Team.new(
            espn_id: team_info["id"],
            name: team_info["name"],
            display_name: team_info["displayName"],
            short_name: team_info["shortDisplayName"],
            nickname: team_info["nickname"],
            location: team_info["location"],
            color: team_info["color"],
            alternate_color: team_info["alternateColor"],
            logo_url: team_info.dig("logos", 0, "href"),
            logo_dark_url: team_info.dig("logos", 1, "href"),
            active: team_info["isActive"],
            position: nil
          )
        end

        add_standings_data(teams_with_standings)
      end
    end

    def fetch_standings
      Rails.cache.fetch("espn_standings", expires_in: CACHE_EXPIRY) do
        generate_mock_standings
      end
    end

    private

    def add_standings_data(teams)
      standings = fetch_standings
      teams.map do |team|
        standing = standings.find { |s| s[:espn_id] == team.espn_id }
        position = standing&.dig(:position)

        ::Domain::Team.new(
          espn_id: team.espn_id,
          name: team.name,
          display_name: team.display_name,
          short_name: team.short_name,
          nickname: team.nickname,
          location: team.location,
          color: team.color,
          alternate_color: team.alternate_color,
          logo_url: team.logo_url,
          logo_dark_url: team.logo_dark_url,
          active: team.active,
          position: position
        )
      end
    end

    def generate_mock_standings
      [
        { espn_id: "364", position: 1 },   # Liverpool
        { espn_id: "359", position: 2 },   # Arsenal
        { espn_id: "363", position: 3 },   # Chelsea
        { espn_id: "382", position: 4 },   # Manchester City
        { espn_id: "361", position: 5 },   # Newcastle
        { espn_id: "362", position: 6 },   # Aston Villa
        { espn_id: "393", position: 7 },   # Nottingham Forest
        { espn_id: "331", position: 8 },   # Brighton
        { espn_id: "370", position: 9 },   # Fulham
        { espn_id: "367", position: 10 },  # Tottenham
        { espn_id: "337", position: 11 },  # Brentford
        { espn_id: "360", position: 12 },  # Manchester United
        { espn_id: "371", position: 13 },  # West Ham
        { espn_id: "384", position: 14 },  # Crystal Palace
        { espn_id: "349", position: 15 },  # Bournemouth
        { espn_id: "380", position: 16 },  # Wolves
        { espn_id: "368", position: 17 },  # Everton
        { espn_id: "357", position: 18 },  # Leeds
        { espn_id: "366", position: 19 },  # Sunderland
        { espn_id: "379", position: 20 }   # Burnley
      ]
    end

    private

    def make_request(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      response = http.request(request)

      if response.code == "200"
        JSON.parse(response.body)
      else
        Rails.logger.error "ESPN API request failed: #{response.code} - #{response.message}"
        nil
      end
    rescue StandardError => e
      Rails.logger.error "ESPN API request error: #{e.message}"
      nil
    end
  end
end
