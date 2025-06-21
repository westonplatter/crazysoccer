class Team
  attr_reader :espn_id, :name, :display_name, :short_name, :nickname, 
              :location, :color, :alternate_color, :logo_url, :logo_dark_url, :active

  def initialize(attributes = {})
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) if respond_to?(key)
    end
  end

  # Create Team instance from ESPN API team data
  def self.from_espn_data(team_data)
    team_info = team_data["team"]
    new(
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
      active: team_info["isActive"]
    )
  end

  # For future ranking - placeholder for now
  def ranking_score
    # TODO: Implement actual ranking based on wins/losses when we get that data
    rand(1..100)
  end
end

$ git config --global user.name "Kwibe Merci"
$ git config --global user.email kwibemerci16@gmail.com
$ git config --global init.defaultBranch main
$ git config --global core.editor "code --wait"
$ git config --global pull.rebase false