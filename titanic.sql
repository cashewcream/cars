-- For this project, I used MySQL to perform the analysis.
-- Created a table and imported the dataset from kaggle https://www.kaggle.com/datasets/yasserh/titanic-dataset to MySQL.
CREATE TABLE titanic.train (
PassengerId INT NULL,
Survived INT NULL,
Pclass INT NULL,
Name TEXT NULL,
Sex TEXT NULL,
Age VARCHAR(4) NULL,
SibSp INT NULL,
Parch INT NULL,
Ticket TEXT NULL,
Fare FLOAT NULL,
Cabin TEXT NULL,
Embarked TEXT NULL)
-- all 891 imported

-- Checking for duplicates
SELECT 
	PassengerId, Name, Age
FROM titanic.train
GROUP BY PassengerId, Name, Age
HAVING COUNT(*)>1
-- None returned 

-- Created a new table to work with
CREATE TABLE titanic.clean AS(
SELECT PassengerID, Name,Sex, Age, 
-- Combined SibSp, Parch + 1 passenger for total family size
(SibSp + Parch + 1) AS Family_size,
-- Rename departure ports
    CASE Embarked
    WHEN 'S' THEN 'Southampton'
    WHEN 'Q' THEN 'Queenstown'
    WHEN 'C' THEN 'Cherbourg'
    ELSE 'Not avaliable'
    END 'Embarked',
-- Assign passenger class
    CASE Pclass
    WHEN 1 THEN 'First Class'
	WHEN 2 THEN 'Second Class'
	ELSE 'Third Class'
	END AS 'Passenger_class',
-- Did the passenger survived?
    CASE Survived
    WHEN 0 THEN 'Died'
	WHEN 1 THEN 'Survived'
    END AS 'Survived'
FROM titanic.train)


-- Survived and deceased grouped by passenger class
SELECT 
Passenger_class,
COUNT(CASE WHEN Survived ='Survived'THEN 1 ELSE NULL END) as survived,
COUNT(CASE WHEN Survived = 'Died' THEN 1 ELSE NULL END) as deceased
FROM titanic.clean
GROUP BY Passenger_class 

-- survived and deceased grouped by sex
SELECT 
Sex,
COUNT(CASE WHEN Survived ='Survived'THEN 1 ELSE NULL END) as survived,
COUNT(CASE WHEN Survived ='Died' THEN 1 ELSE NULL END) as died
FROM titanic.clean
GROUP BY Sex
 
 -- Passenger count by departure port
 SELECT Embarked, COUNT(Embarked) AS total_passenger
 FROM titanic.clean
 GROUP BY Embarked

-- Count by family size
SELECT Family_size, COUNT(Family_size) AS family_size_count
FROM titanic.clean
GROUP BY Family_size

-- Count by age and passenger class
SELECT Age, Passenger_class, COUNT(*) AS count_age_pclass
FROM titanic.clean
GROUP BY Age, Passenger_class
