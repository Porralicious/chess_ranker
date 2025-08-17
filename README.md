# Chess Ranker App

Chess Ranker is a basic application for a local chess club which wants to keep track of their members. They want to keep track of each member and their ranking and games played.

Member can be
- Registered
- Edited and delete

Matches can be 
- Recorded

Ranking is done automatically after a match is record using the following set of rules
- If the higher-ranked player wins against their opponent, neither of their ranks change.
- If it’s a draw, the lower-ranked player can gain one position, unless the two players are
adjacent. So if the players are ranked 10th and 11th, and it’s a draw, no change in ranking
takes place. But if the players are ranked 10th and 15th, and it’s a draw, the player with
rank 15 will move up to rank 14 and the player with rank 10 will stay the same.
- If the lower-ranked player beats a higher-ranked player, the higher-ranked player will
move one rank down, and the lower-level player will move up by half the difference
between their original ranks. For example, if players ranked 10th and 16th play and the
lower-ranked player wins, the first player will move to rank 11th and the other player will
move to rank (16 - 10) / 2 = 3 placed up to rank 13th.


Notes:
When starting please seed the users with the following command
`bin/rails db:seed`
Application is running Rails 8 and ensure to run migrations using 
`bin/rails db:migrate`