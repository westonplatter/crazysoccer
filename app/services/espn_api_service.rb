require 'net/http'
require 'json'

class EspnApiService
  BASE_URL = 'https://site.api.espn.com/apis/site/v2/sports/soccer'.freeze
  PREMIER_LEAGUE = 'eng.1'.freeze
  CACHE_EXPIRY = 1.hour

  class << self
    def fetch_teams
      Rails.cache.fetch('espn_teams', expires_in: CACHE_EXPIRY) do
        url = "#{BASE_URL}/#{PREMIER_LEAGUE}/teams"
        response = make_request(url)
        
        return [] unless response
        teams_data = response.dig('sports', 0, 'leagues', 0, 'teams') || []
        teams_data.map { |team_data| Team.from_espn_data(team_data) }
      end
    end

    private

    def make_request(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      
      if response.code == '200'
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