SELECT count("id") AS "Players Who Bat Opposite to Throw"
FROM "players"
WHERE ("bats" is 'R' AND "throws" is 'L')
    OR ("bats" is 'L' and "throws" is 'R');