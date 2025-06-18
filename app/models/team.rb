class Team
  attr_accessor :espn_id, :name, :display_name, :short_name, :nickname, 
                :location, :color, :alternate_color, :logo_url, :logo_dark_url, :active

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end

  # Create Team instance from ESPN API team data
  def self.from_espn_data(team_data)
    new(
      espn_id: team_data["id"],
      name: team_data["name"],
      display_name: team_data["displayName"],
      short_name: team_data["shortDisplayName"],
      nickname: team_data["nickname"],
      location: team_data["location"],
      color: team_data["color"],
      alternate_color: team_data["alternateColor"],
      logo_url: team_data.dig("logos", 0, "href"),
      logo_dark_url: team_data.dig("logos", 1, "href"),
      active: team_data["isActive"]
    )
  end

  # For future ranking - placeholder for now
  def ranking_score
    # TODO: Implement actual ranking based on wins/losses when we get that data
    rand(1..100)
  end
end