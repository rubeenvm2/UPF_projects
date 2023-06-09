DROP SCHEMA IF EXISTS nba_db;
CREATE DATABASE IF NOT EXISTS nba_db
DEFAULT CHARACTER SET 'utf8mb4'
DEFAULT COLLATE 'utf8mb4_general_ci';
USE nba_db;

CREATE TABLE IF NOT EXISTS Person(
ID_CARD INT(9) UNSIGNED,
Person_name VARCHAR(20),
Surname VARCHAR(20),
Nationality VARCHAR(30),
Gender VARCHAR(15),
Year_birth DATE,
CONSTRAINT pk_person PRIMARY KEY (ID_CARD)
);

CREATE TABLE IF NOT EXISTS Conference(
Conf_name VARCHAR(40),
Geographical_location VARCHAR(30) NOT NULL,
CONSTRAINT pk_conference PRIMARY KEY (Conf_name) 
);

CREATE TABLE IF NOT EXISTS Arena(
Arena_name VARCHAR(50),
City VARCHAR(40),
Capacity INT(10) UNSIGNED,
CONSTRAINT pk_arena PRIMARY KEY (Arena_name)
);

CREATE TABLE IF NOT EXISTS Zone(
Arena VARCHAR(30),
Code_zone INT(2) UNSIGNED,
Is_VIP BOOLEAN,
CONSTRAINT pk_zone PRIMARY KEY (Code_zone, Arena),
CONSTRAINT fk_arena_zone FOREIGN KEY (Arena) REFERENCES Arena(Arena_name)
ON DELETE RESTRICT  
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Seat(
Arena VARCHAR(30),
Zone INT(2) UNSIGNED,
Number_seat INT(2) UNSIGNED,
Colour VARCHAR(15),
CONSTRAINT pk_seat PRIMARY KEY (Arena, Zone, Number_seat),
CONSTRAINT fk_zone_seat FOREIGN KEY (Zone) REFERENCES Zone(Code_zone)
ON DELETE RESTRICT  
ON UPDATE CASCADE,
CONSTRAINT fk_arena_seat FOREIGN KEY (Arena) REFERENCES Arena(Arena_name)
ON DELETE RESTRICT  
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Head_Coach(
ID_CARD_HC INT(9) UNSIGNED,
Percentage_victories FLOAT(30,20) UNSIGNED DEFAULT 0,
Salary FLOAT(30,10) UNSIGNED,
CONSTRAINT pk_hc PRIMARY KEY (ID_CARD_HC), 
CONSTRAINT fk_id_hc FOREIGN KEY (ID_CARD_HC) REFERENCES Person(ID_CARD)
ON DELETE RESTRICT
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Team(
Team_name VARCHAR(40),
City VARCHAR(40),
Annual_budged INT(20) UNSIGNED,
NBA_Rings INT(3) UNSIGNED,
Conference VARCHAR(40),
Head_coach INT(9) UNSIGNED,
Arena_name VARCHAR(30),
CONSTRAINT pk_team PRIMARY KEY (Team_name), 
CONSTRAINT fk_conf_team FOREIGN KEY (Conference) REFERENCES Conference(Conf_name)
ON DELETE SET NULL  
ON UPDATE CASCADE,
CONSTRAINT fk_coach_team FOREIGN KEY (Head_coach) REFERENCES Head_Coach(ID_CARD_HC)
ON DELETE SET NULL  
ON UPDATE CASCADE,
CONSTRAINT fk_arena_team FOREIGN KEY (Arena_name) REFERENCES Arena(Arena_name)
ON DELETE SET NULL  
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS National_Team(
Year_play INT(4) UNSIGNED,
Country VARCHAR(40),
Head_coach INT(9) UNSIGNED,
CONSTRAINT pk_nat_team PRIMARY KEY (Year_play, Country),
CONSTRAINT fk_coach_nat_team FOREIGN KEY (Head_coach) REFERENCES Head_Coach(ID_CARD_HC)
ON DELETE SET NULL  
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Hopper(
ID_CARD_H INT(9) UNSIGNED,
Year_PRO INT(4) UNSIGNED,
University_drafted VARCHAR(50),
NBA_Champions INT(2) UNSIGNED,
CONSTRAINT pk_hopper PRIMARY KEY (ID_CARD_H),
CONSTRAINT fk_id_hopper FOREIGN KEY (ID_CARD_H) REFERENCES Person(ID_CARD)
ON DELETE RESTRICT
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Play_Team(
ID_Hopper INT(9) UNSIGNED,
Team_name VARCHAR(40),
Date_signed_in DATE,
Salary INT(10) UNSIGNED,
Date_signed_out DATE,
Shirt_number INT(2) UNSIGNED,
CONSTRAINT pk_play_team PRIMARY KEY (ID_Hopper, Team_name, Date_signed_in), 
CONSTRAINT fk_team_name_play_team FOREIGN KEY (Team_name) REFERENCES Team(Team_name)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT fk_ID_hopper_play_team FOREIGN KEY (ID_Hopper) REFERENCES Hopper(ID_CARD_H)
ON DELETE RESTRICT
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Play_Nat_Team(
Year_play INT(4) UNSIGNED,
Country_Nat_team VARCHAR(40),
ID_Hopper INT(9) UNSIGNED,
Shirt_number INT(2) UNSIGNED,
CONSTRAINT pk_play_nat_team PRIMARY KEY (Year_play, Country_Nat_team, ID_Hopper), 
CONSTRAINT fk_year_country_play_nat_team FOREIGN KEY (Year_play, Country_Nat_team) REFERENCES National_Team(Year_play, Country)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT fk_ID_hopper_play_nat_team FOREIGN KEY (ID_Hopper) REFERENCES Hopper(ID_CARD_H)
ON DELETE RESTRICT
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Draft(
Year_draft INT(4) UNSIGNED,
CONSTRAINT pk_draft PRIMARY KEY (Year_draft)
);


CREATE TABLE IF NOT EXISTS Drafted(
Team VARCHAR(40),
Hopper INT(9) UNSIGNED,
Rank_chosen INT(2) UNSIGNED NOT NULL,
Year_chosen INT(4) UNSIGNED NOT NULL,
CONSTRAINT pk_drafted PRIMARY KEY (Team, Hopper), 
CONSTRAINT fk_team_drafted FOREIGN KEY (Team) REFERENCES Team(Team_name)
ON DELETE RESTRICT  
ON UPDATE CASCADE,
CONSTRAINT fk_hopper_drafted FOREIGN KEY (Hopper) REFERENCES Hopper(ID_CARD_H)
ON DELETE RESTRICT  
ON UPDATE CASCADE,
CONSTRAINT fk_year_drafted FOREIGN KEY (Year_chosen) REFERENCES Draft(Year_draft)
ON DELETE RESTRICT  
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Assistant_Coach(
ID_CARD_AC INT(9) UNSIGNED,
Speciality VARCHAR(20),
ID_CARD_Boss INT(9) UNSIGNED,
Team_coaching VARCHAR(40),
CONSTRAINT pk_ac PRIMARY KEY (ID_CARD_AC), 
CONSTRAINT fk_team_coaching_ac FOREIGN KEY (Team_coaching) REFERENCES Team(Team_name)
ON DELETE SET NULL  
ON UPDATE CASCADE,
CONSTRAINT fk_id_ac FOREIGN KEY (ID_CARD_AC) REFERENCES Person(ID_CARD)
ON DELETE RESTRICT  
ON UPDATE CASCADE,
CONSTRAINT fk_boss_id_ac FOREIGN KEY (ID_CARD_Boss) REFERENCES Assistant_Coach(ID_CARD_AC)
ON DELETE SET NULL  
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Regular_Season(
Year_RS INT(4) UNSIGNED,
Date_Start DATE NOT NULL,
Date_End DATE NOT NULL,
CONSTRAINT pk_RS PRIMARY KEY (Year_RS)
);

CREATE TABLE IF NOT EXISTS Play_RS(
Team_play VARCHAR(40),
Year_RS INT(4) UNSIGNED,
Is_winner BOOLEAN,
CONSTRAINT pk_play_RS PRIMARY KEY (Team_play, Year_RS),
CONSTRAINT fk_team_play_rs FOREIGN KEY (Team_play) REFERENCES Team(Team_name)
ON DELETE RESTRICT  
ON UPDATE CASCADE,
CONSTRAINT fk_year_rs FOREIGN KEY (Year_RS) REFERENCES Regular_Season(Year_RS)
ON DELETE RESTRICT  
ON UPDATE CASCADE
);

