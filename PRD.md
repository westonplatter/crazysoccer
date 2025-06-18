# Product Requirements Document (PRD)
## Soccer Dashboard for Enthusiastic Fans

### Overview
A web application that provides soccer fans with real-time insights into their favorite teams, players, and matches. The platform will focus on rankings, statistics, and rivalries to keep fans engaged with current season performance.

### Target Users
- **Primary**: Enthusiastic soccer fans who want to stay updated on team and player performance
- **Secondary**: Casual fans looking for quick insights into popular matches and rivalries

### Core Features (Phase 1)

#### 1. Team Rankings Dashboard
- **Route**: `/teams`
- **Purpose**: Display Premier League teams ranked by season performance
- **Ranking Method**: Wins and losses (primary ranking criteria)
- **Key Metrics**: 
  - Win/loss records
  - League position
  - Goals scored/conceded
  - Recent form

#### 2. Player Performance Dashboard  
- **Route**: `/players`
- **Purpose**: Show individual player statistics and scoring leaders
- **Key Metrics** (Phase 1):
  - Points scored per game
  - Cumulative points for the season
  - Goal scorers leaderboard
- **Future Metrics**: Assists, other performance indicators

### Data Integration
- **Primary Data Source**: ESPN API (Premier League - `eng.1`)
- **Team Data**: `https://site.api.espn.com/apis/site/v2/sports/soccer/eng.1/teams`
- **Player Data**: `https://sports.core.api.espn.com/v2/sports/soccer/leagues/eng.1/seasons/2024/teams/{teamId}/athletes`
- **League Focus**: Premier League (corrected from MLS)
- **Update Frequency**: Live data pulls from ESPN API
- **Data Challenge**: Multi-step API calls required (team info + individual player stats)

### Technical Requirements
- Built on Rails 8.0.2 with PostgreSQL
- Responsive design for mobile and desktop
- Fast loading times for data-heavy dashboards
- RESTful API structure for future expansion

### Success Metrics
- User engagement time on dashboards
- Return visitor rate
- Page load performance
- Data accuracy and freshness

### Implementation Progress (Phase 1)

#### ✅ Completed
- **Team PORO Class**: Created `app/models/team.rb` (Plain Old Ruby Object, no database)
- **ESPN API Service**: Created `app/services/espn_api_service.rb` to fetch live Premier League data
- **Teams Controller**: Created `app/controllers/teams_controller.rb` with index action
- **Routes Configuration**: Added `/teams` route and set as root path
- **Teams Dashboard View**: Created responsive grid layout with team cards showing:
  - Team logos, names, nicknames, locations
  - ESPN ID and active status
  - Live data from ESPN API (no database storage)

#### 🔧 Next Steps
- **Database Setup**: Run `bin/rails db:create` to set up PostgreSQL database
- **Server Testing**: Test complete flow at `http://localhost:3000`
- **Data Validation**: Verify ESPN API data structure and handling
- **Styling Improvements**: Enhance CSS and responsive design
- **Error Handling**: Improve API failure scenarios

#### 📁 Files Created
- `app/models/team.rb` - Team data structure
- `app/services/espn_api_service.rb` - ESPN API integration  
- `app/controllers/teams_controller.rb` - Teams controller
- `app/views/teams/index.html.erb` - Teams dashboard template
- `config/routes.rb` - Updated with teams routes

### Future Considerations (Beyond Phase 1)
- User accounts and authentication
- Match predictions and analysis
- Rivalry tracking and head-to-head comparisons
- Personalized team following
- Mobile app development
- Social features and fan discussions
- Additional player metrics (assists, etc.)
- Win/loss rankings (need to find ESPN standings endpoint)

---

## Questions for Clarification

### Data Source & Integration
1. What is the specific data feed/API you're using? (URL, documentation, authentication requirements)
2. What data format does it provide? (JSON, XML, frequency of updates)
3. Which leagues/competitions will we cover initially? (Premier League, La Liga, etc.)
4. Do we need to store historical data or just current season?

### Team Rankings Specifics
5. How should teams be ranked? (Points, goal difference, custom algorithm?)
6. Should we show league tables or cross-league rankings?
7. Do you want filtering by league, country, or division?
8. What time period for "current season" - calendar year or league season?

### Player Performance Details
9. Which player statistics are most important to display?
10. Should players be ranked globally or within their leagues/teams?
11. Do you want player comparison features?
12. Should we include player photos, club affiliations, nationality?

### User Experience
13. Do you need user accounts in Phase 1, or anonymous browsing only?
14. Any specific design preferences or existing brand guidelines?
15. Should the site update in real-time during matches?
16. Do you want any filtering, searching, or sorting capabilities?

### Technical Constraints
17. Any performance requirements (page load times, concurrent users)?
18. Hosting preferences or constraints?
19. Do you need an admin interface for content management?
20. Any accessibility requirements (WCAG compliance)?

### Business Requirements
21. Is this a public site or gated in any way?
22. Any monetization plans (ads, subscriptions) that affect the UI?
23. What's the target launch timeline for Phase 1?