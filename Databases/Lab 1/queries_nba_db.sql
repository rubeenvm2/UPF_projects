# Query 1
SELECT 
ID_CARD, Person_name AS Name, Surname, Nationality, Gender, Year_birth, Year_PRO, University_drafted, NBA_Champions
FROM Person JOIN Hopper 
ON (Person.ID_CARD = Hopper.ID_CARD_H) 
WHERE Nationality NOT LIKE "U%S%";

# Query 2
SELECT
Team_name, City, Annual_budged, Arena_name AS Arena
FROM Team
WHERE
Arena_name = (SELECT Arena_name FROM Team GROUP BY Arena_name HAVING COUNT(Arena_name) > 1);

# Query 3
SELECT
Person_name AS Name, Surname, Year_birth
From Person JOIN Head_Coach
ON (Person.ID_CARD = Head_Coach.ID_CARD_HC)
WHERE Percentage_victories > 30
ORDER BY Percentage_victories DESC;

# Query 4
SELECT 
Conf_name AS Conference, Geographical_location, COUNT(Conference)
FROM Conference JOIN Team
ON (Conference.Conf_name = Team.Conference)
GROUP BY Conference;

# Query 5
SELECT
ID_CARD, Person_name as Name, Surname, Nationality, Year_chosen as Draft_Year, Team as Franchise, Rank_chosen as Position
FROM Drafted JOIN Hopper 
ON (Drafted.Hopper = Hopper.ID_CARD_H)
JOIN Person
ON (Person.ID_CARD = Hopper.ID_CARD_H)
WHERE Year_chosen = 2019;

# Query 6
SELECT
Person_name as Name, Surname, Year_PRO as PRODebutYear
FROM Play_Team JOIN Hopper
ON (Play_Team.ID_Hopper = Hopper.ID_CARD_H)
JOIN Person
ON (Person.ID_CARD = Hopper.ID_CARD_H)
WHERE Team_name = 'Los Angeles Lakers';

# Query 7
SELECT
Person_name as Name, Surname, Country_Nat_team as Country
FROM Play_Nat_Team JOIN Hopper
ON (Play_Nat_Team.ID_Hopper = Hopper.ID_CARD_H)
JOIN Person
ON (Person.ID_CARD = Hopper.ID_CARD_H)
WHERE Country_Nat_team = Nationality;

# Query 8 Idea:
SELECT
ID_CARD, Person_name AS Name, Surname, Nationality, Gender, Year_birth, Speciality
FROM Assistant_Coach JOIN Person
ON (Assistant_Coach.ID_CARD_AC = Person.ID_CARD)
WHERE ID_CARD_Boss IS NULL;

# Query 9
SELECT 
Person_name as Name, Surname, ID_CARD
FROM Person 
WHERE (Person_name, Surname) IN (SELECT Person_name, Surname FROM Person GROUP BY Person_name, Surname HAVING COUNT(*) > 1);

# Query 10
SELECT
Person_name as Name, Surname, Country, Team_name, Year_RS
FROM Head_Coach JOIN National_Team
ON (Head_Coach.ID_CARD_HC = National_Team.Head_coach)
JOIN Team
ON (Head_Coach.ID_CARD_HC = Team.Head_coach)
JOIN Play_RS
ON (Team.Team_name = Play_RS.Team_play)
JOIN Person
ON (Head_Coach.ID_CARD_HC = Person.ID_CARD)
WHERE National_Team.Year_play = Play_RS.Year_RS;

# Query 11
SELECT 
Person_name AS Name, Surname, Salary, (Salary * 0.12) AS Salary_Reduced
FROM Person JOIN Hopper 
ON (Person.ID_CARD = Hopper.ID_CARD_H) 
JOIN Play_Team
ON (Hopper.ID_CARD_H = Play_Team.ID_Hopper)
WHERE Nationality LIKE "U%S%";

# Query 12
SELECT
Person_name AS Name, Surname, Year_PRO AS PRODebutYear, University_drafted, Country_Nat_team, ID_CARD_H
FROM Hopper JOIN Person
ON (Person.ID_CARD = Hopper.ID_CARD_H)
LEFT JOIN Play_Nat_Team
ON (Hopper.ID_CARD_H = Play_Nat_Team.ID_Hopper)
WHERE (Year_PRO > 2020 AND University_drafted IS NULL) OR (Year_PRO > 2020 AND Play_Nat_Team.Country_Nat_team IS NULL);

# Query 13
SELECT * FROM Team;						# Taula abans de modificar-la (un cop executat per primer cop ja queda modificada)
SET SQL_SAFE_UPDATES = 0;
UPDATE Team 
SET NBA_Rings = (SELECT COUNT(*) 
FROM Play_RS
WHERE ((Is_winner > 0) AND (Play_RS.Team_play = Team.Team_name))
GROUP BY Team_play
);
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM Team;						# Taula després de modificar-la