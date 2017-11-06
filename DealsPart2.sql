#Indicate that we are using the deals database
USE deals;

#Execute a test query
SELECT *
FROM Companies
WHERE CompanyName like '%Inc.';

#Select companies sorted by CompanyName
SELECT *
FROM Companies
ORDER BY CompanyID;

#Select Deal Parts with dollar values using a join
SELECT DealName, PartNumber, DollarValue
FROM Deals,DealParts
WHERE Deals.DealID = DealParts.DealID;

#Select Deal Parts with dollar values using join
SELECT DealName, PartNumber, DollarValue
FROM Deals join DealParts on (Deals.DealID = DealParts.DealID);

#show each comapny involved in each deal.
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

# Create a view that matches companies to deals
CREATE View CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

# A test of the CompanyDeals view
SELECT * FROM CompanyDeals;

#Create a dealsview named DealValues that lists the DealID, total dollar value and number of parts for each deal.
CREATE View DealValues AS
SELECT DealID, DollarValue,PartNumber
FROM DealParts;
# A test of the DealValues view
SELECT * FROM DealValues;

#Create a view named DealSummary that lists the DealID, DealName, number of players, total dollar value, and number of parts for each deal.
CREATE View DealSummary AS
SELECT Deals.DealID, DealName,DollarValue,PartNumber,PlayerID # not sure whether 'number of players' is point to PlayerID
FROM DealParts 
	JOIN Deals ON (Deals.DealID = DealParts.DealID)
	JOIN Players ON (Players.DealID = Dealparts.DealID);
    
# A test of the DealSummary view
SELECT * FROM DealSummary;

#Create a view called DealsByType that lists TypeCode, number of deals, and total value of deals for each deal type.
CREATE View DealsByType AS
SELECT TypeCode,DealTypes.DealID,DollarValue
FROM DealTypes 
	Left JOIN DealParts ON (DealTypes.DealID = DealParts.DealID);
    
# A test of the DealSummary view
SELECT * FROM DealsByType;

#Create a view called DealPlayers that lists the CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder.
CREATE View DealPlayers AS
SELECT CompanyID,DealName,RoleCode
FROM Deals
	JOIN Players ON (Deals.DealID = Players.DealID);

# A test of the DealSummary view
SELECT * FROM DealPlayers;

#Create a view called DealsByFirm that lists the FirmID, Name, number of deals, and total value of deals for each firm.
CREATE View DealsByFirm AS
SELECT FirmID,Name, Deals.DealID,DollarValue
FROM Deals
	JOIN DealParts ON (Deals.DealID = DealParts.DealID)
    RIGHT JOIN Firms ON (Deals.DealName = Firms.Name);
    
# A test of the DealsByFirm view
SELECT * FROM DealsByFirm;
