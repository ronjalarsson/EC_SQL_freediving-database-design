/*This file contains Ronja's code for adding at least 5 rows in each table*/
USE freedive;
GO

/*Data for table 1 EducationSystems*/
INSERT INTO EducationSystems(education_system_name)
  VALUES
  ('PADI'),
  ('Pure Apnea'),
  ('Molchanovs'),
  ('SSI'),
  ('Apnea Total');

/*Data for table 2 Instructors*/
INSERT INTO Instructors(first_name, last_name, birthdate, e_mail, nationality)
    VALUES
    ('Dennis', 'Asplund', '1990-04-05', 'dennis@freedive.com', 'Sweden'),
    ('Annelie', 'Pompe', '1981-02-25', 'annelie@freedive.com', 'Sweden'),
    ('Adam', 'Stern', '1987-01-12', 'adams@deepweek.com', 'Australia'),
    ('Pavol', 'Ivanov', '1980-07-08', 'pavol@atlantis.com', 'Slovakia'),
    ('Linda', 'Paganelli', '1966-10-06', 'linda@atlantis.com', 'Italy');

/*Data for table 3 EducationSystemsInstructors*/
INSERT INTO EducationSystemsInstructors(education_system_id, instructor_id)
    VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (4, 5);

/*Data for table 4 Level*/
INSERT INTO Level(level, level_description, fim_requirement_m, cwt_requirement_m, dny_requirement_m, sta_requirement_sec)
    VALUES
    (1, 'Basic Freediver', 10, 10, 25, 90),
    (2, 'Advanced Freediver', 20, 20, 50, 150),
    (3, 'Master Freediver', 32, 32, 75, 210),
    (4, 'Assisting Instructor', 35, 35, 75, 210),
    (5, 'Instructor', 40, 40, 75, 210);

/*Data for table 5 Freedivers*/
INSERT INTO Freedivers(first_name, last_name, birthdate, e_mail, nationality)
    VALUES
    ('Ronja', 'Larsson', '1989-11-24', 'ronja@freedive.com', 'Sweden'),
    ('Mai', 'Sailor', '1989-03-28', 'mai@freedive.com', 'Japan'),
    ('Lydia', 'Jansson', '1968-09-05', 'lydia@freedive.com', 'The Netherlands'),
    ('John', 'Smith', '1970-12-15', 'john@freedive.com', 'Ireland'),
    ('Peter', 'Wong', '1998-05-06', 'peter@freedive.com', 'China');

/*Data for table 6 Certification*/
INSERT INTO Certification(issue_date, freediver_id, instructor_id, education_system_id, [level])
VALUES
    ('2018-06-10', 1, 1, 1, 1),
    ('2018-04-15', 1, 2, 2, 1),
    ('2019-12-12', 1, 3, 3, 2),
    ('2023-01-12', 1, 4, 4, 3),
    ('2023-04-30', 1, 5, 4, 5);

/*Data for table 7 PersonalBest*/
INSERT INTO PersonalBest(freediver, fim_m, cwt_m, dny_m, sta_sec)
VALUES
    (1, 36, 32, 75, 201),
    (2, 30, 30, 207, 240),
    (3, 50, 59, 125, 240),
    (4, 17, 15, 50, 120),
    (5, 65, 60, 150, 245);

/*Data for table 8 Product*/
INSERT INTO Product(product_brand, product_name, product_price_sek)
VALUES
    ('Octopus', 'Noseclip carbon', 350),
    ('Alchemy', 'Bifins V30', 5800),
    ('Mares', 'Snorkel', 189),
    ('Mares', 'Freediving watch', 2330),
    ('Mares', 'Freediving mask', 399);

/*Data for table 9 PurchaseOrder*/
INSERT INTO PurchaseOrder(order_date, freediver_id)
VALUES
    ('2022-11-24', 1),
    ('2022-12-05', 1),
    ('2022-12-07', 3),
    ('2022-12-07', 4),
    ('2022-12-20', 5);

/*Data for table 10 OrderProduct*/
INSERT INTO OrderProduct(order_id, product_id)
VALUES
    (9999, 999),
    (10000, 1000),
    (10001, 1002),
    (10002, 1001),
    (10003, 1000);
