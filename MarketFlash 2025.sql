--TABLE CREATION--
--Based on the ERD graphic and details, here is the SQL code to create the database schema
--for the MarketFlash Entities and their relationships, normalized to avoid redundancy.
--Question - DATE and DATETIME stamps, would it be an error if I am going to use DATE only?
--The reason why am I thinking the DATE will far enough, it is the information outcome.
--Possibly, if I am going to use a DATETIME stamp it will lead to
--volume of data encreasing coz of every symbol we have in the code are actual bit in the system.
--Am I right?
-- Create the Clients table
CREATE TABLE Clients (
Client_ID INT PRIMARY KEY,
Client_Name VARCHAR(25),
Contact_Details TEXT,
Industry VARCHAR(25),
Contract_Start_Date DATE,
Contract_End_Date DATE
);
-- Create the Campaigns table
CREATE TABLE Campaigns (
Campaign_ID INT PRIMARY KEY,
Client_ID INT,
Campaign_Name VARCHAR(25),
Start_Date DATETIME,
End_Date DATETIME,
Budget NUMERIC(10, 2),
FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID)

);
-- Create the Employees table
CREATE TABLE Employees (
Employee_ID INT PRIMARY KEY,
Employee_Name VARCHAR(25),
Role VARCHAR(25),
Contact_Info VARCHAR(25),
Department VARCHAR(25),
Employee_Since DATETIME
);
-- Create the Campaign_Employees table (Many-to-Many relationship)
CREATE TABLE Campaign_Employees (
CE_ID INT PRIMARY KEY,
Campaign_ID INT,
Employee_ID INT,
FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID),
FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);
-- Create the Platforms table
CREATE TABLE Platforms (
Platform_ID INT PRIMARY KEY,
Platform_Name VARCHAR(25),
URL VARCHAR(255),
Contact_Person VARCHAR(25),
Contact_Phone VARCHAR(25),
Contact_Email VARCHAR(25)
);

-- Create the Campaign_Platforms table (Many-to-Many relationship)
CREATE TABLE Campaign_Platforms (
CP_ID INT PRIMARY KEY,
Campaign_ID INT,
Platform_ID INT,
FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID),
FOREIGN KEY (Platform_ID) REFERENCES Platforms(Platform_ID)
);
-- Create the Influencers table
CREATE TABLE Influencers (
Influencer_ID INT PRIMARY KEY,
Influencer_Name VARCHAR(25),
Social_Handle VARCHAR(25),
Follower_Count INT,
Contact_Details VARCHAR(25)
);
-- Create the Campaign_Influencers table (Many-to-Many relationship)
CREATE TABLE Campaign_Influencers (
CI_ID INT PRIMARY KEY,
Campaign_ID INT,
Influencer_ID INT,
FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID),
FOREIGN KEY (Influencer_ID) REFERENCES Influencers(Influencer_ID)
);
-- Create the Contents table
CREATE TABLE Contents (

Content_ID INT PRIMARY KEY,
Campaign_ID INT,
Title VARCHAR(25),
Description TEXT,
Media_Type VARCHAR(25),
Creation_Date DATE,
FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID)
);
-- Create the Payments table
CREATE TABLE Payments (
Payment_ID INT PRIMARY KEY,
Campaign_ID INT,
Date DATETIME,
Amount NUMERIC(10, 2),
Payment_Type VARCHAR(25),
Payment_Details TEXT,
FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID)
);
-- Create the Advertisements table
CREATE TABLE Advertisements (
Ad_ID INT PRIMARY KEY,
Platform_ID INT,
Campaign_ID INT,
Ad_Name VARCHAR(255),
Type VARCHAR(25),
Duration INT,
Budget NUMERIC(10, 2),
FOREIGN KEY (Platform_ID) REFERENCES Platforms(Platform_ID),

FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID)
);
-- Create the Metrics table
CREATE TABLE Metrics (
Metric_ID INT PRIMARY KEY,
Campaign_ID INT,
Impressions INT,
Clicks INT,
Engagement NUMERIC(10, 2),
Conversion_Rate DECIMAL(5, 2),
FOREIGN KEY (Campaign_ID) REFERENCES Campaigns(Campaign_ID)
);

--1. Primary Keys (PK):
--Each table has a primary key defined (PK), as indicated in the ERD.
--2. Foreign Keys (FK):
--Relationships are established using foreign keys, linking the tables appropriately.
--3. Data Types:
-- VARCHAR(25) for short strings like names and roles.
-- TEXT for longer descriptions.
-- NUMERIC for monetary values and engagement metrics.
-- DATETIME for dates and timestamps.

--ROW FILLING--
--Now I'am going to fill up to 5 rows in every entities.
--I am populates all tables with sample data, maintaining the integrity of relationships

--and providing meaningful values for testing.
-- Insert data into Clients table
INSERT INTO Clients (Client_ID, Client_Name, Contact_Details, Industry, Contract_Start_Date, Contract_End_Date)
VALUES
(1, 'Tech Innovators', 'contact@techinnovators.com', 'Technology', '2025-01-01', '2025-12-31'),
(2, 'Green Future', 'contact@greenfuture.org', 'Environment', '2025-02-01', '2025-11-30'),
(3, 'Media Masters', 'info@mediamasters.com', 'Media', '2025-03-01', '2025-10-31'),
(4, 'EduPro', 'support@edupro.net', 'Education', '2025-04-01', '2025-09-30'),
(5, 'Wellness World', 'hello@wellnessworld.com', 'Healthcare', '2025-05-01', '2025-08-31');
-- Insert data into Campaigns table
INSERT INTO Campaigns (Campaign_ID, Client_ID, Campaign_Name, Start_Date, End_Date, Budget)
VALUES
(1, 1, 'Tech Innovation Drive', '2025-01-15 08:00:00', '2025-03-15 18:00:00', 50000.00),
(2, 2, 'Go Green Initiative', '2025-02-10 09:00:00', '2025-04-10 17:00:00', 40000.00),
(3, 3, 'Media Blitz 2025', '2025-03-20 10:00:00', '2025-05-20 19:00:00', 60000.00),
(4, 4, 'Education for All', '2025-04-15 09:00:00', '2025-06-15 18:00:00', 30000.00),
(5, 5, 'Health is Wealth', '2025-05-10 08:30:00', '2025-07-10 16:30:00', 45000.00);
-- Insert data into Employees table
INSERT INTO Employees (Employee_ID, Employee_Name, Role, Contact_Info, Department, Employee_Since)
VALUES
(1, 'Alice Johnson', 'Campaign Manager', 'alice.johnson@marketflash.com', 'Marketing', '2023-01-15 09:00:00'),
(2, 'Bob Smith', 'Data Analyst', 'bob.smith@marketflash.com', 'Data', '2022-02-20 10:00:00'),
(3, 'Clara Davis', 'Content Creator', 'clara.davis@marketflash.com', 'Creative', '2021-03-25 11:00:00'),
(4, 'David Lee', 'Social Media Specialist', 'david.lee@marketflash.com', 'Social Media', '2024-04-10 09:00:00'),
(5, 'Eve Brown', 'Sales Executive', 'eve.brown@marketflash.com', 'Sales', '2023-05-15 08:30:00');
-- Insert data into Campaign_Employees table

INSERT INTO Campaign_Employees (CE_ID, Campaign_ID, Employee_ID)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);
-- Insert data into Platforms table
INSERT INTO Platforms (Platform_ID, Platform_Name, URL, Contact_Person, Contact_Phone, Contact_Email)
VALUES
(1, 'Facebook', 'https://www.facebook.com', 'Mark Zuckerberg', '1234567890', 'mark@facebook.com'),
(2, 'Instagram', 'https://www.instagram.com', 'Kevin Systrom', '2345678901', 'kevin@instagram.com'),
(3, 'Twitter', 'https://www.twitter.com', 'Elon Musk', '3456789012', 'elon@twitter.com'),
(4, 'LinkedIn', 'https://www.linkedin.com', 'Ryan Roslansky', '4567890123', 'ryan@linkedin.com'),
(5, 'TikTok', 'https://www.tiktok.com', 'Shou Zi Chew', '5678901234', 'shou@tiktok.com');
-- Insert data into Campaign_Platforms table
INSERT INTO Campaign_Platforms (CP_ID, Campaign_ID, Platform_ID)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4),
(5, 5, 5);
-- Insert data into Influencers table
INSERT INTO Influencers (Influencer_ID, Influencer_Name, Social_Handle, Follower_Count, Contact_Details)
VALUES
(1, 'John Doe', '@john_doe', 1000000, 'john.doe@gmail.com'),

(2, 'Jane Smith', '@jane_smith', 850000, 'jane.smith@gmail.com'),
(3, 'Emily White', '@emily_white', 600000, 'emily.white@gmail.com'),
(4, 'Chris Black', '@chris_black', 750000, 'chris.black@gmail.com'),
(5, 'Sarah Green', '@sarah_green', 500000, 'sarah.green@gmail.com');
-- Insert data into Campaign_Influencers table
INSERT INTO Campaign_Influencers (CI_ID, Campaign_ID, Influencer_ID)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);
-- Insert data into Contents table
INSERT INTO Contents (Content_ID, Campaign_ID, Title, Description, Media_Type, Creation_Date)
VALUES
(1, 1, 'Tech Ad', 'Highlighting innovation.', 'Video', '2025-01-10'),
(2, 2, 'Eco Poster', 'Promoting eco practices.', 'Image', '2025-02-05'),
(3, 3, 'Media Promo', 'Awareness campaign.', 'Text', '2025-03-15'),
(4, 4, 'Edu Poster', 'Supporting education.', 'Image', '2025-04-01'),
(5, 5, 'Health Tips Video', 'Tips for health.', 'Video', '2025-05-01');
-- Insert data into Payments table
INSERT INTO Payments (Payment_ID, Campaign_ID, Date, Amount, Payment_Type, Payment_Details)
VALUES
(1, 1, '2025-01-20 12:00:00', 10000.00, 'Bank Transfer', 'Ad creation.'),
(2, 2, '2025-02-15 13:00:00', 15000.00, 'Credit Card', 'Eco poster design.'),
(3, 3, '2025-03-25 14:00:00', 20000.00, 'Bank Transfer', 'Promo expenses.'),
(4, 4, '2025-04-20 15:00:00', 12000.00, 'PayPal', 'Poster printing.'),

(5, 5, '2025-05-15 16:00:00', 18000.00, 'Bank Transfer', 'Video production.');
-- Insert data into Advertisements table
INSERT INTO Advertisements (Ad_ID, Platform_ID, Campaign_ID, Ad_Name, Type, Duration, Budget)
VALUES
(1, 1, 1, 'Tech Ad', 'Video', 30, 5000.00),
(2, 2, 2, 'Green Ad', 'Image', 15, 4000.00),
(3, 3, 3, 'Media Ad', 'Text', 45, 6000.00),
(4, 4, 4, 'Edu Ad', 'Image', 20, 3000.00),
(5, 5, 5, 'Health Ad', 'Video', 60, 4500.00);
-- Insert data into Metrics table
INSERT INTO Metrics (Metric_ID, Campaign_ID, Impressions, Clicks, Engagement, Conversion_Rate)
VALUES
(1, 1, 100000, 5000, 2000.5, 2.5),
(2, 2, 80000, 4000, 1500.3, 1.9),
(3, 3, 120000, 7000, 3000.7, 2.8),
(4, 4, 60000, 3000, 1200.9, 2.0),
(5, 5, 90000, 4500, 1800.2, 2.3);
--1. Integrity Maintained: Each table is populated with meaningful, connected data.
--2. Data Relationships: Foreign keys are consistently linked, ensuring a functional database.

--TESTING--
--Ok,
--now let's test my database with some of the queries.
--I am going to write 5 queries to understand the database is set right and return to me information required.

--1. List all campaigns with their respective clients and platforms
--This query ensures that the Campaigns, Clients, and Platforms tables are properly linked through Campaign_Platforms.
SELECT
Campaigns.Campaign_Name,
Clients.Client_Name,
Platforms.Platform_Name
FROM
Campaigns
JOIN
Clients ON Campaigns.Client_ID = Clients.Client_ID
JOIN
Campaign_Platforms ON Campaigns.Campaign_ID = Campaign_Platforms.Campaign_ID
JOIN
Platforms ON Campaign_Platforms.Platform_ID = Platforms.Platform_ID;

--2. Find all employees managing campaigns and their assigned roles
--This query validates the many-to-many relationship between Employees and Campaigns through Campaign_Employees.
SELECT
Employees.Employee_Name,
Employees.Role,
Campaigns.Campaign_Name
FROM
Employees
JOIN
Campaign_Employees ON Employees.Employee_ID = Campaign_Employees.Employee_ID
JOIN
Campaigns ON Campaign_Employees.Campaign_ID = Campaigns.Campaign_ID;

--3. List all influencers hired for campaigns and their follower count
--This query tests the many-to-many relationship between Influencers and Campaigns via Campaign_Influencers.
SELECT
Campaigns.Campaign_Name,
Influencers.Influencer_Name,
Influencers.Follower_Count
FROM
Campaigns
JOIN
Campaign_Influencers ON Campaigns.Campaign_ID = Campaign_Influencers.Campaign_ID
JOIN
Influencers ON Campaign_Influencers.Influencer_ID = Influencers.Influencer_ID;

--4. Get a breakdown of advertisements by campaign and platform
--This query ensures the connection between Advertisements, Campaigns, and Platforms.
SELECT
Campaigns.Campaign_Name,
Platforms.Platform_Name,
Advertisements.Ad_Name,
Advertisements.Type,
Advertisements.Budget
FROM
Advertisements
JOIN
Campaigns ON Advertisements.Campaign_ID = Campaigns.Campaign_ID

JOIN
Platforms ON Advertisements.Platform_ID = Platforms.Platform_ID;

--5. Calculate total payments and metrics for each campaign
--This query checks the aggregation of payment and metrics data for each campaign.
SELECT
Campaigns.Campaign_Name,
SUM(Payments.Amount) AS Total_Payments,
Metrics.Impressions,
Metrics.Clicks,
Metrics.Engagement,
Metrics.Conversion_Rate
FROM
Campaigns
LEFT JOIN
Payments ON Campaigns.Campaign_ID = Payments.Campaign_ID
LEFT JOIN
Metrics ON Campaigns.Campaign_ID = Metrics.Campaign_ID
GROUP BY
Campaigns.Campaign_ID, Metrics.Impressions, Metrics.Clicks, Metrics.Engagement, Metrics.Conversion_Rate;