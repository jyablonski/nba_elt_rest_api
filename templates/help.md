# REST API Help Page
Documentation on various Endpoints, Pages, and Functionality provided by the API
## GET Endpoints
### Daily Predictions
- The Daily Predictions Endpoint is used to showcase Win Predictions from the ML Model for that night's games

### Daily Schedule
- The Daily Schedule Endpoint is used to show Upcoming NBA Schedule Information

### Game Types
- The Game Types Endpoint is used to offer an aggregated breakdown of the point differential of all NBA Games in the Season to-date with the following bins:
  - Clutch Game (1 - 5 pts)
  - 10 pt Game (6 - 10 pts)
  - 20 pt Game (11 - 20 pts)
  - Blowout Game (21+ pts)
  - This is additionally split out between Regular Season & Playoffs, for a total of 8 total bins by the end of the Season

### Injuries
- The Injuries Endpoint returns all NBA Players with active injuries pulled from [basketball-reference](https://www.basketball-reference.com/friv/injuries.fcgi)

### Injuries (Team Specific)
- The Injuries Team Specfic Endpoint is used to return all NBA Players with active injuries for a specific Team

### Player Stats
- The Player Stats Endpoint is used to show all NBA Stats + Aggregations for Active NBA Players

### Reddit Comments
- The Reddit Comments Endpoint is used to showcase recent Reddit comments from https://www.reddit.com/r/nba

### Standings
- The Standings Endpoint is used to show NBA Team Standings, Win Loss Records, and a Total Count of Active Injuries per Team

### Team Ratings
- The Team Ratings Endpoint is used to show basic & advanced Team Stats for all NBA Teams

### Team Ratings (Team Specific)
- The Team Ratings Endpoint is used to show basic & advanced Team Stats for a specific Team

### Transactions
- The Transactions Endpoint is used to show all NBA Team Transactions in the current Season

### Twitter Comments
- The Twitter Comments Endpoint is used to showcase recent Twitter comments referencing nba-related content

## Feedback Page
- The Feedback Page allows users to submit anonymous Feedback to the Application Developer

## Login Page
- The Login Page allows users to either create a new Account, or login to an existing Account where they can then access the following Pages:

### Tonight's Bets
- This Page allows the current user to make Win Predictions for that night's NBA Games

### Past Bets
- This Page shows all Past Predictions made by the current User
  - Total Predictions, Total Correct Predictions, and Total Profit Metrics are available to the User
  - User's also have the option of downloading their Prediction History as of the current date into a CSV
