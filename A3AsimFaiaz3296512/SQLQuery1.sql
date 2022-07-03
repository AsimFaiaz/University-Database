DROP DATABASE IF EXISTS SCSUniOfSunshine
GO
CREATE DATABASE SCSUniOfSunshine
go 
USE SCSUniOfSunshine
go
use master
GO




--CREATE TABLES

DROP TABLE Enroll
DROP TABLE CoursePrivilege 
DROP TABLE Privileges
DROP TABLE CourseOfferings  
DROP TABLE loan
DROP TABLE reservation 
DROP TABLE AcquisitionRequest 
DROP TABLE MembersStaff 
DROP TABLE MembersStudent  
DROP TABLE Members
DROP TABLE ResourceImmovable 
DROP TABLE ResourceMoveable
DROP TABLE SResource
DROP TABLE ResourceCategory 
DROP TABLE ResourceLocation  

 
--ResourceLocation Table

CREATE TABLE ResourceLocation(
locID						VarChar(20) NOT NULL,														--Location Unique ID as PK
building					VarChar(20) NOT NULL,														--Building Name AND Number
room						VarChar(20) NOT NULL,														--Room name and Number
campus						Char(20)	NOT NULL,														--Name of the campus
PRIMARY KEY(locID))
GO


--ResourceCatagory Table

CREATE TABLE ResourceCategory(
catID						VarChar(20) NOT NULL,														--Catagory Unique ID as PK
name						VarChar(30) NOT NULL,														--Name of the Item
CaDescription				VarChar(30) NOT NULL,														-- Description of Catagory
maxPeriod					INT NOT NULL,																--Max period to hold or reserve
PRIMARY KEY (catID))
GO 	


 --Resource Table

CREATE TABLE SResource(
resID						VarChar(20) NOT NULL,																							--Unique Resource ID 
locID						VarChar(20),																									--Location unique ID as Foreign key
catID						VarChar(20),																									--Catagory unique ID as Foreign key  																							
ReDescription				Char(20)	NOT NULL,																							--Resource Description
ReStatus					Char(10)	DEFAULT 'AVAILABLE' CHECK (ReStatus IN ('AVAILABLE','OCCUPIED','DAMAGED')) NOT NULL,				--Resource Able/Disable status
PRIMARY KEY(ResID),	
FOREIGN KEY(locID) REFERENCES ResourceLocation(locID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(catID) REFERENCES ResourceCategory(catID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
GO


--ResourceMovable Table

Create table ResourceMoveable(
resID						VarChar(20) NOT NULL,		--Unique Resource ID and Foreign key as well
name						VarChar(20) NOT NULL,		--Name of the Item
Manufacturer				VarChar(20) NOT NULL, 		--Manufacturer of the Resource 
Make						Char(20)	NOT NULL, 		--Counrty make 
Model						VarChar(20) NOT NULL,		--Name of the model 
RmYear						VarChar(20) NOT NULL, 		--Built year
AssetValue					Int,						--Asset Value of the Resource
PRIMARY KEY(ResID),
Foreign Key (ResID) references SResource(ResID)  on update cascade on delete no action
); 
GO

--ResourceImmovable Table 

CREATE TABLE ResourceImmovable(
ResID						VarChar(20) Not Null,				--Unique Resource ID and Foreign key as well
Capacity					Int,								--Max capacity of the resource
PRIMARY KEY (ResID),
FOREIGN KEY (ResID) REFERENCES SResource(ResID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
GO

--Members Table

CREATE TABLE Members(
MemID						VarChar(20) NOT NULL,																					--Unique member ID
Name						Char(20)	NOT NULL,																					--Name of the Member
MeAddress					VarChar(100), 																							--Address of the member
PhoneNumber					Varchar(15) NOT NULL,																					--Phone Number of the member
Email						VarChar(20),																							--Email of Member
MeStatus					Char(10)	DEFAULT 'ACTIVE' CHECK (MeStatus IN ('ACTIVE','NOT-ACTIVE')) NOT NULL, 						--Activity status of Member
PRIMARY KEY (MemID))
GO 
 


--MembersStudent Table

CREATE TABLE MembersStudent(
MemID						VarChar(20) NOT NULL,				--Unique member ID
penaltyPoints				Int									--Total Penalty points of Students
PRIMARY KEY (MemID),
FOREIGN KEY (MemID) REFERENCES Members(MemID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
GO

----MembersStudent Table

CREATE TABLE MembersStaff(
MemID						VarChar(20) NOT NULL,				--Unique member ID
Position					Char(20),							--Working field of Staff member
PRIMARY KEY (MemID),
FOREIGN KEY (MemID) REFERENCES Members(MemID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
GO

-- AcquisitionRequest Table

CREATE TABLE AcquisitionRequest(
reqID						VarChar(20) NOT NULL,																--Unique ID 
MemID						VarChar(20) NOT NULL, 																--Member unique ID as foreign key  
name						Char(20)	NOT NULL,																--Name of the requested item
description					Char(20)	NOT NULL, 																--Description of the requested item
manufacturer				VarChar(20) NOT NULL, 																--Manufacturer of the requested item
make						Char(20)	NOT NULL, 																--Cunntry make of the item
model						VarChar(20) NOT NULL, 																--Model of the item
ArYear						VarChar(20),																		--What year the item was made
price						Int,																				--Market price of the item 
urgency						VarChar(20)	DEFAULT 'NOW' CHECK (urgency IN ('NOW','BOOK ON AVAILABLE')),			--How urgent the item for who requested
assignStatus				Char(20),																			--Current status of the item
fundCode					VarChar(20),																		--FundCode of the Item
vendorCode					VarChar(20),																		--Vendor Code of the item
otherRequest				Char(50)	NULL,																	--Special request made by who want the item
PRIMARY KEY (reqID),
FOREIGN KEY(MemID) REFERENCES Members(MemID) ON UPDATE CASCADE ON DELETE NO ACTION
);
GO

--Reservation Table;

CREATE TABLE Reservation(
reserveID					VarChar(20) NOT NULL,						--Unique ID
resID						VarChar(20) NOT NULL, 						--Resource Unique ID as Foreign Key 
MemID						VarChar(20) NOT NULL, 						--Members Unique ID as Foreign key 
requiredTimeAndDate			Date		NOT NULL, 						--Reservation time and date
DueTimeAndDate				Date		NOT NULL, 						--Reservation end time and date
PRIMARY KEY (reserveID),
FOREIGN KEY (MemID) REFERENCES Members(MemID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (ResID) REFERENCES SResource(ResID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
Go

--Loan Table

CREATE TABLE Loan(
loanID						VarChar(20) NOT NULL,					--UniqueID
resID						VarChar(20),							--Resource Unique ID as Foreign key
MemID						VarChar(20),							--Member Unique ID as foreign key 
item						VarChar(20) NOT NULL, 					--Item Catagory
pickDate					Date		NOT NULL,					--Pick up date
dueDate						Date		NOT NULL,					--Due Date
returnDate					Date,									--Return Date
PRIMARY KEY(loanID),	
FOREIGN KEY (ResID) REFERENCES SResource(ResID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (MemID) REFERENCES Members(MemID) ON UPDATE CASCADE ON DELETE NO ACTION,  
);
GO

--CourseOfferings Table
CREATE TABLE CourseOfferings(
offID						VarChar(20) NOT NULL,					--Unique ID
MemID						VarChar(20),							--Member unique ID as foreign key 
courseNameAndID					VarChar(20) NOT NULL,					--Name of the Course 
semester				    VarChar(20)	NOT NULL, 					--Name of the Course
OffYear						VarChar(20)	NOT NULL, 					--Year offered the course
PRIMARY KEY(offID),
FOREIGN KEY (MemID) References Members(MemID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
GO


--Privileges Table

CREATE TABLE Privileges(
privID						VarChar(20)		NOT NULL,			--Unique ID
catID						VarChar(20),						--Catagory Unique ID as Foreign Key
offID						Varchar(20),						--Student Unique ID as Foreign key 
PDescription					Char(50)	NULL,				--What kind of privilege is that
numberOfItems				VarChar(10)		NOT NULL, 			--How many itemes can be loaned
PRIMARY KEY(PrivID),
FOREIGN KEY (catID) REFERENCES ResourceCategory(catID) ON UPDATE CASCADE ON DELETE NO ACTION, 
FOREIGN KEY (offID) REFERENCES CourseOfferings(offID) ON UPDATE CASCADE ON DELETE NO ACTION, 
);
GO

--CoursePrivilege Table

CREATE TABLE CoursePrivilege(
privID					Varchar(20)		NOT NULL,			--Unique Privileges ID
offID					VarChar(20)		NOT NULL,			--Unique CourseOffering ID
PRIMARY KEY(privID, offID),
FOREIGN KEY (privID) references Privileges(PrivID) ON UPDATE CASCADE ON DELETE cascade,
);  
GO

--Enroll Table

CREATE TABLE Enroll(
offID					VarChar(20)		NOT NULL,			--Unique CourseOffering ID
MemID					VarChar(20)		NOT NULL,			--Unique Member ID
PRIMARY KEY (offID, MemID),  
);
GO


--DATA Creation

--Insert ResourceLocation

INSERT INTO ResourceLocation VALUES
('L0','ICT', 'ICT337','CALLAGHAN'),
('L1','HUNTER', 'HP197', 'CALLAGHAN'),
('L2', 'ES', 'ES101', 'CALLAGHAN')
GO

--Insert ResourceCategory

INSERT INTO ResourceCategory VALUES   
('C0', 'CAMERA','ALL KIND OF CAMERAS','6'),
('C1', 'LAPTOP','ALL KIND OF LAPTOPS', '6'),
('C2', 'SPEAKER','ALL KIND OF HEADPHONES','6')
GO

--Insert Resource

INSERT INTO SRESOURCE VALUES
('MVR10','L0' ,'C0' , 'CANON 60D CAMERA', 'OCCUPIED' ),
('MVR20', 'L1', 'C1' , 'DELL LAPTOP', 'AVAILABLE'),
('MVR30', 'L2', 'C2' , 'BOSS SPEAKER', 'DAMAGED'),
('IMVR40', 'L1', 'C2', 'RADIO STATION', 'AVAILABLE'),
('IMVR50', 'L2', 'C1' , 'STUDIO', 'OCCUPIED'),
('IMVR60', 'L0', 'C1' , 'MEETING ROOM', 'OCCUPIED')
GO

--Insert ResourceMovable

INSERT INTO ResourceMoveable VALUES
('MVR10', 'CAMERA', 'CANON', 'THAILAND','D60', '2006', '650'),
('MVR20', 'LAPTOP', 'DELL','AUSTRALIA' , 'R60', '2010', '1650'),
('MVR30', 'SPEAKER', 'BOSS','CHINA', 'H60', '2016', '250')
GO

--Insert ResourceImmovable

INSERT INTO ResourceImmovable VALUES
('IMVR40', '40'),
('IMVR50', '50'),
('IMVR60', '60')
GO

--Insert Members

INSERT INTO Members VALUES
('MSTU1','ASIM FA', '2 JESMOND STREET', '012410', 'AF@GMAIL.COM','ACTIVE'),
('MSTU2','OUDOM MO', '9 HERALD STREET', '019510', 'OM@GMAIL.COM','ACTIVE'), 
('MSTU3','JON SMITH', '19 HEXA STREET', '082950', 'JS@GMAIL.COM','NOT-ACTIVE'),
('MSTF4','ANANDA KA', '50 KING STREET', '014569', 'AK@GMAIL.COM','ACTIVE'),
('MSTF5','SUHUAU LU', '39 HUNTER STREET', '017890', 'SL@GMAIL.COM','ACTIVE'),
('MSTF6','SHAMUS KO', '18 COBRA STREET', '012512', 'SK@GMAIL.COM','NOT-ACTIVE')
GO

--INSERT STUDENT

INSERT INTO MembersStudent VALUES
('MSTU1','0'),
('MSTU2','5'),
('MSTU3','9')
GO

--INSERT STAFF
 
 INSERT INTO MembersStaff VALUES
 ('MSTF4','TUTOR'),
 ('MSTF5', 'LECTURER'),
 ('MSTF6', 'CO-ORDINATOR')
 GO

 --INSERT ACQREQUEST

 INSERT INTO AcquisitionRequest VALUES  
 ('REQ1','MSTU1' , 'CAMERA', 'CANON D60 CAMERA', 'CANON', 'THAILAND', 'D60', '2020', '650', 'NOW', 'IN STOCK', 'FUND001', 'VEND001', 'NULL' ),
 ('REQ2','MSTF4' , 'LAPTOP', 'DELL R60 LAPTOP', 'DELL', 'AUSTRALIA', 'R60', '2019', '1650', 'NOW', 'NOT IN STOCK', 'FUND002', 'VEND002', 'NULL' ),
 ('REQ3', 'MSTU3' , 'SPEAKER', 'BOSS H60 SPEAKER', 'BOSS', 'CHINA', 'H60', '2020', '250', 'NOW', 'NOT IN STOCK', 'FUND003', 'VEND003', 'NULL' )
 GO 
 
--INSERT RESERVATION

INSERT INTO Reservation VALUES    
('Rev1','IMVR50','MSTU1', '2020-06-11', '2020-06-11'), 
('Rev2','IMVR40','MSTF4', '2019-07-11', '2019-07-11'), 
('Rev3','IMVR60','MSTF5', '2020-05-11', '2020-05-11')
GO    

--INSERT LOAN

INSERT INTO Loan VALUES
('LN1','MVR10', 'MSTU1', 'CAMERA', '2020-06-11' ,'2020-06-15','2020-06-15'),
('LN2','MVR20', 'MSTU2', 'LAPTOP', '2020-05-11' ,'2020-05-15','2020-06-02'),
('LN3','MVR30', 'MSTU3', 'SPEAKER', '2020-06-18' ,'2020-06-22','2020-06-24')
GO   

--INSERT COURSE OFFERINGS

INSERT INTO CourseOfferings VALUES
('OFF1','MSTU1','INFT1004', 'SEM 1', '2020'),
('OFF2','MSTU2','COMP1140', 'SEM 2', '2020'),  
('OFF3','MSTU3','SENG2280', 'SEM 1', '2020')
GO  

--INSERT PRIVILEGES

INSERT INTO Privileges VALUES
('PR1', 'C0', 'OFF3', 'ONLY FOR SENG STUDENTS', '1'),
('PR2', 'C2', 'OFF2', 'ONLY FOR INFT STUDENTS', '1'), 
('PR3', 'C1', 'OFF1', 'ONLY FOR COMP STUDENTS', '1')
GO

--INSERT COURSE PRIVILEGES

INSERT INTO CoursePrivilege VALUES
('PR1','OFF1'),
('PR2','OFF2'), 
('PR3','OFF3')
GO

--INSERT INTO ENROLL

INSERT INTO Enroll VALUES
('OFF1', 'MSTU1'),
('OFF2', 'MSTU2'), 
('OFF3', 'MSTU3')
GO



 






SELECT * FROM SResource
SELECT * FROM ResourceCategory
SELECT * FROM ResourceLocation
SELECT * FROM ResourceMoveable 
SELECT * FROM ResourceImmovable
SELECT * FROM Members 
SELECT * FROM MembersStudent
SELECT * FROM MembersStaff
SELECT * FROM AcquisitionRequest
SELECT * FROM Reservation
SELECT * FROM Loan
SELECT * FROM CourseOfferings
SELECT * FROM Privileges
SELECT * FROM CoursePrivilege
SELECT * FROM Enroll
SELECT * FROM Members  
SELECT * FROM AcquisitionRequest 
SELECT * FROM Reservation 

------------------------------------------------------------
--Ques NO 1


--Print the name of student(s) who  has/have enrolled in the course with course id xxx.  
--COURSE ID = COMP1140

SELECT * FROM Members
SELECT * FROM CourseOfferings

select m.Name
from Members m, CourseOfferings c
where m.MemID = c.MemID and courseNameAndID ='COMP1140'

--------------------------------------------------------------

--Ques NO 2

--Print the maximal number of speakers that the student with name xxx can borrow. The student is enrolled in the course with course id yyy. Note: speaker is a category
--NAME = OUDOM MO   COURSEnAMEaNDiD = COMP1140     CATAGORY = SPEAKER

SELECT * FROM CourseOfferings
SELECT * FROM Privileges
SELECT * FROM ResourceCategory
SELECT * FROM Members  


 
select p.numberOfItems 
from ResourceCategory c, Privileges p, CourseOfferings o, Members m 
where m.memId=o.MemID and c.catID=p.catID and  m.name='OUDOM MO' and o.courseNameAndID='COMP1140' and c.name='SPEAKER'

----------------------------------------------------------------- 
 --Question no 3

 --For a staff member with id number xxx, print his/her name and phone number, the total number of acquisition requests and the total number of reservations that the staff had made in 2019. 
 

 SELECT * FROM Members
 SELECT * FROM AcquisitionRequest
 SELECT * FROM Reservation


 select m.name, m.phoneNumber, count(a.ArYear) as TotalRequest, count(r.requiredTimeAndDate) as TotalReservation
 from Members m, AcquisitionRequest a, Reservation r
 where m.MemID = a.MemID and m.MemID = r.MemID and a.ArYear = '2019' and r.requiredTimeAndDate = '2019-07-11'
 group by m.Name, m.PhoneNumber

-----------------------------------------------------------------

 --Que no 4

--Print the name(s) of the student member(s) who has/have borrowed the category with the name of camera, of which the model is xxx, in this year.

--MODEL = D60     ITEM = CAMERA   datePart code from google(reference)

SELECT * FROM ResourceMoveable 
SELECT * FROM Members
SELECT * FROM Loan

Select m.name
From members m, ResourceMoveable r, loan l
Where m.MemID = l.MemID and r.resID = l.resID and r.Model = 'D60' and l.item = 'CAMERA' and datepart(year, pickDate)=datepart(year, GETDATE())

------------------------------------------------------------------

--que no 6
--For each of the three days, including May 1, 2020, June 5, 2020 and September 19, 2020,  print  the  date,  the  name  of  the  room  with  name  xxx,  and  the  total  number  of  reservations made for the room on each day.

--USING THE DATES FROM MY DATABASE

SELECT * FROM Reservation
SELECT * FROM ResourceLocation
SELECT * FROM SResource

SELECT l.room, r.requiredTimeAndDate, count(r.requiredTimeAndDate) as TotalReservation
From ResourceLocation l, Reservation r, SResource s
where r.resID = s.resID and s.locID = l.locID and r.requiredTimeAndDate = '2020-06-11' and r.requiredTimeAndDate = '2019-07-11' and r.requiredTimeAndDate = '2020-05-11' and l.room = 'ICT337'
GROUP BY l.room, r. requiredTimeAndDate


---------------------------------------------------------------------
--Que no. 5

--Find the moveable resource that is the mostly loaned in the current month. Print the resource id and resource name.  
--datepart code from google(reference)

select m.resID, m.name, count(m.resId) as MostlyLoaned 
From ResourceMoveable m, Loan l 
where m.resID=l.resID and datepart(month, pickDate)=datepart(month, GETDATE()) 
group by m.resID, m.name 
Having count(m.resID)>= all (select count(resID) from Loan
where datepart(month, pickDate)=datepart(month, GETDATE())
group by resID)
------------------------------------------------------------------------