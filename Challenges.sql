WITH ChallengeCounts AS (
    SELECT 
        c.hacker_id, 
        MAX(h.name) AS names, 
        COUNT(c.challenge_id) AS num_of_challenges 
    FROM 
        challenges AS c 
    LEFT JOIN 
        hackers AS h ON c.hacker_id = h.hacker_id 
    GROUP BY 
        c.hacker_id 
    ORDER BY 
        num_of_challenges DESC, c.hacker_id
)
SELECT 
    y.hacker_id,
    y.names,
    y.num_of_challenges 
FROM 
    ChallengeCounts AS y 
WHERE 
    y.num_of_challenges = (
        SELECT 
            MAX(num_of_challenges) 
        FROM (
            SELECT 
                num_of_challenges, 
                COUNT(hacker_id) AS num_of_hacker_id 
            FROM 
                ChallengeCounts 
            GROUP BY 
                num_of_challenges
        ) AS temp
    ) 
    OR y.num_of_challenges IN (
        SELECT 
            num_of_challenges 
        FROM (
            SELECT 
                num_of_challenges, 
                COUNT(hacker_id) AS num_of_hacker_id 
            FROM 
                ChallengeCounts 
            GROUP BY 
                num_of_challenges 
            HAVING 
                COUNT(hacker_id) = 1
        ) AS temp1
    );
