
/* 0. Complete the lab to create the SELECT CREATE query!
Reproduce the output:

CREATE TABLE Taverns (
ID int,
Name varchar(100),
Floors int,
LocationID int,
OwnerID int,
)
*/
SELECT 'CREATE TABLE taverns ('  AS queryPiece
UNION ALL
SELECT (CASE WHEN ORDINAL_POSITION != (SELECT MAX(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'taverns') 
THEN CONCAT(COLUMN_NAME, ' ', DATA_TYPE, ',')
ELSE CONCAT(COLUMN_NAME, ' ', DATA_TYPE) END) AS queryPiece
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'taverns'
UNION ALL
SELECT ')'  AS queryPieces

-- OR
DECLARE @max_column INT
SELECT @max_column = MAX(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'taverns'
SELECT 'CREATE TABLE taverns ('  AS queryPiece
UNION ALL
SELECT (CASE WHEN ORDINAL_POSITION != @max_column 
THEN CONCAT(COLUMN_NAME, ' ', DATA_TYPE, ',')
ELSE CONCAT(COLUMN_NAME, ' ', DATA_TYPE) END) AS queryPiece
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'taverns'
UNION ALL
SELECT ')'  AS queryPieces


/*
1. The system should also be able to track Rooms. Rooms should have a status and an associated tavern. There 
should be a way to track Room Stays which will contain a sale, guest, room, the date it was stayed in and the rate
*/
--rooms table
DROP TABLE IF EXISTS [rooms];

CREATE TABLE [rooms] (
ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
roomStatus VARCHAR(250) NOT NULL,
tavernId INT NOT NULL FOREIGN KEY REFERENCES taverns(ID)    
);

INSERT INTO [rooms] (roomStatus, tavernId)
VALUES ('available', 1), ('not available', 2), ('booked', 3);

--roomStays table
DROP TABLE IF EXISTS [roomStays];

CREATE TABLE [roomStays] (
ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
sale VARCHAR(250) NOT NULL,
guestName VARCHAR(250) NOT NULL,
room VARCHAR(250) NOT NULL,
dateIn DATE NOT NULL,
rate MONEY NOT NULL
);

--INSERT INTO [roomStays] (sale, guestName, room, dateIn, rate)
--VALUES 


/*
2. Write a query that returns guests with a birthday before 2000.
*/
SELECT * FROM [guests]
--WHERE YEAR(birthday) < 2000
WHERE DATEPART(YEAR, birthday) < 2000


/*
3. Write a query to return rooms that cost more than 100 gold a night
*/

/*
4.Write a query that returns UNIQUE guest names.
*/
--inserting another row for 'Agnes Doyle' to test UNIQUE names 
INSERT INTO [guests] (tavernId, guestName, notes, birthday, cakeday, guestStatusId, classId)
VALUES (5, 'Agnes Doyle', 'likes oshizushi', '01/01/1980', '01/01/2021', 3, 5 )
SELECT DISTINCT guestName FROM [guests]
/*
5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]
*/
SELECT guestName FROM [guests]
--ORDER BY guestName ASC
ORDER BY guestName DESC
/*
6. Write a query that returns the top 10 highest price sales
*/
SELECT TOP (10) * FROM [sales]
ORDER BY price DESC

/*
7. Write a query to return all the values stored in all Lookup Tables - Lookup tables are the tables we reference
 typically with just an ID and a name. This should be a dynamic combining of all of the tables
*/
SELECT * FROM [locations]
UNION ALL
SELECT * FROM [servicesStatus]
UNION ALL
SELECT * FROM [guestStatus]
UNION ALL
SELECT * FROM [class]
/*
8. Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level 
grouping (lvl 1-10, 10-20, etc)
*/

/*
9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using 
SELECT statements (See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t 
match or make sense! :)
* Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2) 
*/



--1
