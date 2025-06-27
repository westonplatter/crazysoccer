module Domain
  Team = ImmutableStruct.new(:espn_id, :name, :display_name, :short_name, :nickname,
                             :location, :color, :alternate_color, :logo_url, :logo_dark_url, :active, :position) do
    # For future ranking - placeholder for now
    def ranking_score
      # TODO: Implement actual ranking based on wins/losses when we get that data
      rand(1..100)
    end
  end
end
