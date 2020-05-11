# Catan_stats
Persists the results of the turns for a user's Catan game and provides in-game stats


average roll result from db: SELECT avg(result) FROM turns  (NOT Actually a helpful stat)
            --> for activerecord: Turn.average(:result)

Total Number of rows: Turn.count(:result)

Most common (greatest) roll result from db:
    Turn.group(:result).order('count_id DESC').limit(1).count(:id)

average turns per game from db:

Most turns in a game from db: