Use AdventureWorks2016CTP3



Alter Table HumanResources.Employee 
Add ManagerID INT, EmployeeManagerID Int, TeamName VARCHAR(50);

Select BusinessEntityID, ManagerID, EmployeeManagerID, TeamName
from HumanResources.Employee
Where OrganizationLevel = 2
    and JobTitle Like '%Manager%';
--Abocve query shows new fields are null

Update HumanResources.Employee Set ManagerID = 1  --,TeamName = 'Team 1'
Where BusinessEntityID = 3
Update HumanResources.Employee Set ManagerID = 2 -- , TeamName = 'Team 2'
Where BusinessEntityID = 25;
Update HumanResources.Employee Set ManagerID = 3  --, TeamName = 'Team 3'
Where BusinessEntityID = 211;
Update HumanResources.Employee Set ManagerID = 4 -- , TeamName = 'Team 4'
Where BusinessEntityID = 227;
Update HumanResources.Employee Set ManagerID = 5  --, TeamName = 'Team 5'
Where BusinessEntityID = 235;
Update HumanResources.Employee Set ManagerID = 6  
Where BusinessEntityID = 241;
Update HumanResources.Employee Set ManagerID = 7 
Where BusinessEntityID = 249;
Update HumanResources.Employee Set ManagerID = 8  
Where BusinessEntityID = 264;
Update HumanResources.Employee Set ManagerID = 9  
Where BusinessEntityID = 274;
Update HumanResources.Employee Set ManagerID = 10  
Where BusinessEntityID = 285;
--Above query has set the manager IDs
Select BusinessEntityID, ManagerID, EmployeeManagerID, TeamName
from HumanResources.Employee
Where OrganizationLevel = 2
    and JobTitle Like '%Manager%';

Update HumanResources.Employee Set EmployeeManagerID = 00  
Where ManagerID Is Not NULL;

Update HumanResources.Employee Set EmployeeManagerID = 
Round(abs(checksum(NewId()) % 10),2)+1 Where EmployeeManagerID Is NULL;
--280 rows affected with above query

--Run the select with self joins
SELECT
    E.BusinessEntityID AS 'Employee ID',
    E1.LastName +', ' + E1.FirstName AS 'Employee Name',
    E.JobTitle AS 'Employee Title',
    E.EmployeeManagerID AS 'Employee ManagerID',

    M.ManagerID AS 'Manager ID',
    M1.LastName + ', '+ M1.FirstName AS 'Manager Name',
    M.JobTitle AS 'Manager Title'

From HumanResources.Employee E
    Join HumanResources.Employee M
    on E.EmployeeManagerID = M.ManagerID
    Join Person.Person E1
    on E.BusinessEntityID = E1.BusinessEntityID
    Join Person.Person M1
    on M.BusinessEntityID = M1.BusinessEntityID
Where M.ManagerID Is Not Null And E.JobTitle Not Like 'Vice%'
Order by E1.LastName;

--------------Below queries update the team name
Update HumanResources.Employee Set TeamName = 'Team 1'
Where BusinessEntityID = 3
Update HumanResources.Employee Set TeamName = 'Team 2'
Where BusinessEntityID = 25;
Update HumanResources.Employee Set TeamName = 'Team 3'
Where BusinessEntityID = 211;
Update HumanResources.Employee Set  TeamName = 'Team 4'
Where BusinessEntityID = 227;
Update HumanResources.Employee Set TeamName = 'Team 5'
Where BusinessEntityID = 235;
Update HumanResources.Employee Set TeamName = 'Team 6'
Where BusinessEntityID = 241;
Update HumanResources.Employee Set TeamName = 'Team 7'
Where BusinessEntityID = 249;
Update HumanResources.Employee Set TeamName = 'Team 8'
Where BusinessEntityID = 264;
Update HumanResources.Employee Set TeamName = 'Team 9'
Where BusinessEntityID = 274;
Update HumanResources.Employee Set TeamName = 'Team 10'
Where BusinessEntityID = 285;

---Belwo query shows the employees --and mnagaers combined
select
    E.BusinessEntityID
, E.ManagerId
, E.EmployeeManagerID
, E.TeamName
from HumanResources.Employee E
Where E.EmployeeManagerID Is Not NULL and ManagerId is NULL;

select * from 
HumanResources.Employee E 
where E.EmployeeManagerID = '1';
UPDATE
HumanResources.Employee
set TeamName= 'Team 1'
where EmployeeManagerID = '1';
--2nd update
UPDATE
HumanResources.Employee
set TeamName= 'Team 2'
where EmployeeManagerID = '2';
--3rd
UPDATE
HumanResources.Employee
set TeamName= 'Team 3'
where EmployeeManagerID = '3';
--4th
UPDATE
HumanResources.Employee
set TeamName= 'Team 4'
where EmployeeManagerID = '4';
--5th
UPDATE
HumanResources.Employee
set TeamName= 'Team 5'
where EmployeeManagerID = '5';
--6th
UPDATE
HumanResources.Employee
set TeamName= 'Team 6'
where EmployeeManagerID = '6';
--7th
UPDATE
HumanResources.Employee
set TeamName= 'Team 7'
where EmployeeManagerID = '7';
--8th
UPDATE
HumanResources.Employee
set TeamName= 'Team 8'
where EmployeeManagerID = '8';
--9th
UPDATE
HumanResources.Employee
set TeamName= 'Team 9'
where EmployeeManagerID = '9';
--10th
UPDATE
HumanResources.Employee
set TeamName= 'Team 10'
where EmployeeManagerID = '10';
--

--Adding the manager last name
Alter Table HumanResources.Employee 
Add ManagerLastName VARCHAR(50);
--Need to populate the manager last name

update HumanResources.Employee E
set E.ManagerLastName = M1.LastName
where E.
  HumanResources.Employee E
    Join HumanResources.Employee M
    on E.EmployeeManagerID = M.ManagerID
    Join Person.Person E1
    on E.BusinessEntityID = E1.BusinessEntityID
    Join Person.Person M1
    on M.BusinessEntityID = M1.BusinessEntityID





SELECT
    E.BusinessEntityID AS 'Employee ID',
    E1.LastName +', ' + E1.FirstName AS 'Employee Name',
    E.TeamName,
    M1.LastName as 'Manager Last Name'

From HumanResources.Employee E
    Join HumanResources.Employee M
    on E.EmployeeManagerID = M.ManagerID
    Join Person.Person E1
    on E.BusinessEntityID = E1.BusinessEntityID
    Join Person.Person M1
    on M.BusinessEntityID = M1.BusinessEntityID
Where M.ManagerID Is Not Null And E.JobTitle Not Like 'Vice%'
Order by E.TeamName, E.BusinessEntityID;


