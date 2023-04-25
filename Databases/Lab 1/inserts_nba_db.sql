LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_person_v1.csv"
INTO TABLE Person
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_conference_franchise_v1.csv"
IGNORE
INTO TABLE Conference
COLUMNS TERMINATED BY '&&'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 LINES
(Conf_name, Geographical_location, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_ArenaData_v1.csv"
IGNORE
INTO TABLE Arena
COLUMNS TERMINATED BY '$$'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 LINES
(Arena_name, City, Capacity, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_ArenaData_v1.csv"
IGNORE
INTO TABLE Zone
COLUMNS TERMINATED BY '$$'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 LINES
(@dummy, @dummy, @dummy, Arena, Code_zone, Is_VIP, @dummy, @dummy, @dummy, @dummy)
;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_ArenaData_v1.csv"
IGNORE
INTO TABLE Seat
COLUMNS TERMINATED BY '$$'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, Arena, Zone, Number_seat, Colour)
;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_headcoach_v1.csv"
INTO TABLE Head_Coach
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_conference_franchise_v1.csv"
IGNORE
INTO TABLE Team
COLUMNS TERMINATED BY '&&'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 LINES
(@dummy, @dummy, Team_name, City, Annual_budged, NBA_Rings, Head_coach, Arena_name, Conference)
;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_nationalteam_v1.csv"
IGNORE
INTO TABLE National_Team
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Year_play, Country, Head_coach);

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_player_v1.csv"
INTO TABLE Hopper
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_CARD_H, Year_PRO, University_drafted, NBA_Champions);

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_player_franchise_v1.csv"
INTO TABLE Play_Team
COLUMNS TERMINATED BY '@@'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Hopper, Team_name, Shirt_number, Date_signed_in, Date_signed_out, Salary);

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_nationalteam_player_v1.csv"
INTO TABLE Play_Nat_Team
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Year_play, Country_Nat_team, ID_Hopper, Shirt_number);

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_draft_v1.csv"
INTO TABLE Draft
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_draft_player_franchise_v1.csv"
INTO TABLE Drafted
COLUMNS TERMINATED BY '::'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Year_chosen, Hopper, Team, Rank_chosen);

SET FOREIGN_KEY_CHECKS = 0;
LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_assistant_v1.csv"
INTO TABLE Assistant_Coach
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_CARD_AC, Speciality, ID_CARD_Boss, Team_coaching);
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_regularseason_franchise_season_v1.csv"
IGNORE
INTO TABLE Regular_Season
COLUMNS TERMINATED BY '%%'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Year_RS, Date_Start, Date_End, @dummy, @dummy, @dummy);

LOAD DATA INFILE "/ProgramData/MySQL/MySQL Server 8.0/Data/nba_db_regularseason_franchise_season_v1.csv"
INTO TABLE Play_RS
COLUMNS TERMINATED BY '%%'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, Team_play, Year_RS, Is_winner);