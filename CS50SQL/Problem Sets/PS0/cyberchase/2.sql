SELECT "season", "title"
FROM "episodes"
WHERE "episode_in_season" = 1
ORDER BY "season";