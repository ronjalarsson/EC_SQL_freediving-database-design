/*5 queries that cover CRUD and JOIN for the grade G*/
USE freedive;
GO

/*The first letter of CRUD, ‘C’, refers to CREATE aka add, insert. 
In this operation, it is expected to insert a new record using the SQL insert statement. 
I use INSERT INTO statement to create new 5 records within the table Freedivers.*/
INSERT INTO Freedivers (first_name, last_name, birthdate, e_mail, nationality)
    VALUES
    ('Elisabeth', 'Blackforrest', '1983-07-12', 'elisabeth@freedive.com', 'Germany'),
    ('Lizzy', 'Zhao', '1977-12-10', 'lizzy@hiker.cn', 'China'),
    ('Liam', 'Smith', '1976-08-24', 'liam@2971.uk', 'United Kimgdom'),
    ('Sasha', 'Frenzel', '1971-01-29', 'sasha@freedive.com', 'Belgium'),
    ('Ann', 'Cool', '1985-10-26', 'ann@cool.com', 'Belgium');

/*The second letter of CRUD , ‘R’, refers to SELECT (data retrieval) operation. 
The word ‘read’ retrieves data or record-set from a listed table(s). 
I use the SELECT command to retrieve the data from table Freedivers and see that we have 10 freedivers in the system currently, 
after we added the extra 5 freedivers in above code.*/
SELECT *
FROM Freedivers

/*I used below code to retrive data in the table Freedivers and check how many freedivers in the database are from Belgium or China.*/
SELECT *
FROM Freedivers
WHERE nationality = 'Belgium' OR nationality = 'China';

/*I use below code to retrive data in the table Instructors and search for an instructor with the last name Ivanov.*/
SELECT * 
FROM Instructors
WHERE last_name = 'Ivanov';

/*JOIN is used to join different table together in a database.
I use below code with INNER JOIN to get the data about each freediver's name, 
nationality and their personal best record in each freediving discipilin,
by joining the table Freedivers and PersonalBest.
Now we see a view where the chosen details of each freediver and their personal best records.
Since I used INNER JOIN here, we only see the freedivers whose records are saved in the data base.*/
SELECT Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PersonalBest.fim_m, PersonalBest.cwt_m, PersonalBest.dny_m, PersonalBest.sta_sec
FROM Freedivers
INNER JOIN PersonalBest 
ON Freedivers.freediver_id = PersonalBest.freediver;

/*Now I want to see which of the freedivers do not have their personal best record entered yet,
since we added a few extra freedivers in the database.
I use FULL OUTER JOIN for this to join all the rows and columns, the columns with NULL are the columns we need to update.*/
SELECT Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PersonalBest.fim_m, PersonalBest.cwt_m, PersonalBest.dny_m, PersonalBest.sta_sec
FROM Freedivers
FULL OUTER JOIN PersonalBest
ON Freedivers.freediver_id = PersonalBest.freediver;

/*Now I see that we are missing values for all four freediving disciplines for freedivers 6 to 10
So I want to add/INSERT the values for the NULL columns.*/
INSERT INTO PersonalBest(freediver, fim_m, cwt_m, dny_m, sta_sec)
VALUES
    (6, 67, 59, 100, 233),
    (7, 5, 0, 25, 190),
    (8, 70, 63, 125, 250),
    (9, 93, 88, 200, 300),
    (10, 35, 29, 50, 194);

/*Now if I run above FULL OUTER JOIN code again, 
we will see that all columns with NULL are updated with current values.*/

/*The third letter of CRUD, ‘U’, refers to Update operation. 
Using the Update keyword, SQL brings a change to an existing record(s) of the table PersonalBest.
freediver with id 7, Lizzy was a beginner, but now she has achieved new personal best records,
so we want to update her PB records.*/
UPDATE PersonalBest
SET fim_m = 12, cwt_m = 10, dny_m = 50
WHERE freediver = 7;

/*We run below SELECT query to check the updated PersonalBest table and see that freediver 7's records have been updated.*/
SELECT *
FROM PersonalBest;

/*The last letter of the CRUD operation is ‘D’ and it refers to removing a record from a table. 
SQL uses the SQL DELETE command to delete the record(s) from the table.
The stake holder decided to delete level 4 'Assisting Instructor' from the Level table,
because level 3 'Master Freediver' has the same qualification for assisting instructor.*/
DELETE 
FROM Level 
WHERE level = 4 AND level_description = 'Assisting Instructor';

/*When we query the table Level, we see that level 4 has been removed.*/
SELECT *
FROM Level

/*Now, I want to find out the average meters these 10 freedivers can dive within the discipline FIM, 
and the freedivers who can dive to a deeper depth than this average, using a nested query.
I use a math function AVG to get the average of fim_m.*/
SELECT *
FROM PersonalBest
WHERE fim_m > (
    SELECT AVG(fim_m)
    FROM PersonalBest);

/*Now we get a view of the five freedivers who can do FIM to deeper than the average depth in meter,
but let's find out what is the average depth with FIM among these 10 freedivers with AVG function.*/
SELECT AVG(fim_m)
FROM PersonalBest;

/*Wow, so the average depth for all the 10 freedivers can dive to in the discipline of FIM is 47 meters!
I want to use JOIN to make the view easier to read with more details on the 5 divers who can dive deeper than 47 meters with FIM.*/
SELECT Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PersonalBest.fim_m
FROM Freedivers
FULL OUTER JOIN PersonalBest
ON Freedivers.freediver_id = PersonalBest.freediver
WHERE fim_m > (
    SELECT AVG(fim_m)
    FROM PersonalBest);

/*Now, I want to know which freediver can hold their breath the longest with below code.*/
SELECT *
FROM PersonalBest
WHERE sta_sec = (
    SELECT MAX(sta_sec)
    FROM PersonalBest);

/*With above query, we only see the data from table PersonalBest which does not contain the personal info about freediver 9.
We can use this nested query in our earlier JOIN statement to get the full details of freediver 9, check out below code.*/
SELECT Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PersonalBest.fim_m, PersonalBest.cwt_m, PersonalBest.dny_m, PersonalBest.sta_sec
FROM Freedivers
FULL OUTER JOIN PersonalBest
ON Freedivers.freediver_id = PersonalBest.freediver
WHERE sta_sec = (
    SELECT MAX(sta_sec)
    FROM PersonalBest);
/*Now we see clearly that Sasha with freediver ID 9 is the freediver who can hold their breath the longest*/

/*VG Attempt*/
/*I will use GROUP BY function in the code we have written earlier to get a list of our deep freedivers
(divers who can dive to below 32 m with FIM, 32 m with CWT, 75 m with DNY, as well as STA more than 210 sec),
in decsending order by coulmn fim_m.*/
SELECT Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PersonalBest.fim_m, PersonalBest.cwt_m, PersonalBest.dny_m, PersonalBest.sta_sec
FROM Freedivers
FULL OUTER JOIN PersonalBest
ON Freedivers.freediver_id = PersonalBest.freediver
WHERE PersonalBest.fim_m >= 32 AND PersonalBest.cwt_m >= 32 AND PersonalBest.dny_m >= 75 AND PersonalBest.sta_sec >= 210
GROUP BY Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PersonalBest.fim_m, PersonalBest.cwt_m, PersonalBest.dny_m, PersonalBest.sta_sec
ORDER BY fim_m DESC;

/*Now, I want to know how many orders Ronja has made in the system.
I use COUNT function and JOIN function in below code to query a view of it.*/
SELECT COUNT(Freedivers.freediver_id), Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PurchaseOrder.order_id, PurchaseOrder.order_date
FROM Freedivers
JOIN PurchaseOrder
ON Freedivers.freediver_id = PurchaseOrder.freediver_id
WHERE PurchaseOrder.freediver_id = 1
GROUP BY Freedivers.freediver_id, Freedivers.first_name, Freedivers.last_name, Freedivers.nationality, PurchaseOrder.order_id, PurchaseOrder.order_date;

/*We see that Ronja has made 2 orders,
and I want to store the amount of Ronjs's order, 2, into a variable.*/
DECLARE @ronjas_orders INT; -- first, declare a variable called ronjas_orders
SET @ronjas_orders = (  -- second, use the SET statement to assign the value to the variable
  SELECT COUNT(*)
  FROM PurchaseOrder
  WHERE freediver_id = 1
);
SELECT @ronjas_orders AS Ronja_order_count; -- then we can output the variable with SELECT

/*Now, I want to also store the amounts of Ronjs's freediving certifications in a variable with below code.*/
DECLARE @ronjas_certifications INT; -- first, declare a variable called ronjas_certifications
SET @ronjas_certifications = (  -- second, use the SET statement to assign the value to the variable
  SELECT COUNT(*)
  FROM Certification
  WHERE freediver_id = 1
);
SELECT @ronjas_certifications AS Ronja_certification_count; -- then we can output the variable with SELECT
/*After running above query, we can see that Ronja has 2 orders in the system and she has 5 freediving certifications,
both values are stored in a variable.*/