/*This file contains Ronja's code for creating db freedive and 10 tables in the db*/
CREATE DATABASE freedive;
GO

USE freedive;
GO

/*Table 1*/
CREATE TABLE EducationSystems (
    education_system_id INT IDENTITY(1,1) PRIMARY KEY,
    education_system_name VARCHAR(20) NOT NULL
);

/*Table 2*/
CREATE TABLE Instructors (
    instructor_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    birthdate DATE NOT NULL,
    e_mail VARCHAR(100),
    nationality VARCHAR(20)
);

/*Table 3*/
CREATE TABLE EducationSystemsInstructors (
    esi_id INT IDENTITY(1,1) PRIMARY KEY,
    education_system_id INT NOT NULL,
    instructor_id INT NOT NULL,
    FOREIGN KEY(education_system_id) REFERENCES EducationSystems(education_system_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*Table 4*/
CREATE TABLE Level (
    level INT PRIMARY KEY,
    level_description VARCHAR(200) NOT NULL,
    fim_requirement_m INT NOT NULL,
    cwt_requirement_m INT NOT NULL,
    dny_requirement_m INT NOT NULL,
    sta_requirement_sec INT NOT NULL,
);

/*Table 5*/
CREATE TABLE Freedivers (
    freediver_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    birthdate DATE NOT NULL,
    e_mail VARCHAR(100),
    nationality VARCHAR(20)
);

/*Table 6*/
CREATE TABLE Certification (
    certification_number INT IDENTITY(1,1) PRIMARY KEY,
    issue_date DATE NOT NULL,
    freediver_id INT NOT NULL,
    instructor_id INT NOT NULL,
    education_system_id INT NOT NULL,
    level INT NOT NULL,
    FOREIGN KEY(freediver_id) REFERENCES Freedivers(freediver_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(education_system_id) REFERENCES EducationSystems(education_system_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(level) REFERENCES Level(level) ON DELETE CASCADE ON UPDATE CASCADE
);

/*Adding an axtra coulmn for certification number, adding 000 infront of certification_id in table 6*/
ALTER TABLE dbo.Certification
  ADD certification_id
    AS 'FD-' + RIGHT('000' + CAST(certification_number AS VARCHAR(3)) , 3) PERSISTED;

/*Table 7*/
CREATE TABLE PersonalBest (
    freediver INT UNIQUE NOT NULL,
    fim_m INT,
    cwt_m INT,
    dny_m INT,
    sta_sec INT,
);

/*Linking freediver in table 7 as to PK freediver_id in tble 5*/
ALTER TABLE PersonalBest
ADD CONSTRAINT FK_PersonalBest_Freedivers FOREIGN KEY([freediver])
    REFERENCES [Freedivers]([freediver_id]);

/*Table 8*/
CREATE TABLE Product (
    product_id INT IDENTITY(999,1) PRIMARY KEY,
    product_brand VARCHAR(20) NOT NULL,
    product_name VARCHAR(20) NOT NULL,
    product_price_sek FLOAT NOT NULL
);

/*Table 9*/
CREATE TABLE PurchaseOrder (
    order_id INT IDENTITY(9999,1) PRIMARY KEY,
    order_date DATETIME NOT NULL,
    freediver_id INT NOT NULL,
    FOREIGN KEY(freediver_id) REFERENCES Freedivers(freediver_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*Table 10*/
CREATE TABLE OrderProduct (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY(order_id) REFERENCES PurchaseOrder(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);
