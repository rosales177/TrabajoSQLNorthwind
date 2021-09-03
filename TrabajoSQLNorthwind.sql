USE Northwind
GO

-----------------------------------Sección Rosales-----------------------------------------------


DROP PROC IF EXISTS sp_Update_Employees
GO

CREATE PROC sp_Update_Employees
@EmployeeID int not null,
@LastName nvarchar(20) not null,
@FirstName nvarchar(10) not null,
@Title nvarchar(30) null,
@TitleOfCourtesy nvarchar(25) null,
@BirthDate date null,
@HireDate date null,
@Address nvarchar(60) null,
@City nvarchar(15) null,
@Region nvarchar(15) null,
@PostalCode nvarchar(10) null,
@Country nvarchar(15) null,
@HomePhone nvarchar(24) null,
@Extension nvarchar(4) null
as
GO


-----------------------------------Sección Fiorella-----------------------------------------------
-----INSERT----

DROP PROC IF EXISTS sp_Insert_Employees
GO

CREATE PROC sp_Insert_Employees
@LastName nvarchar(20) not null,
@FirstName nvarchar(10) not null,
@Title nvarchar(30) null,
@TitleOfCourtesy nvarchar(25) null,
@BirthDate date null,
@HireDate date null,
@Address nvarchar(60) null,
@City nvarchar(15) null,
@Region nvarchar(15) null,
@PostalCode nvarchar(10) null,
@Country nvarchar(15) null,
@HomePhone nvarchar(24) null,
@Extension nvarchar(4) null
as
GO


INSERT INTO Employees VALUES ('01', 'RAMIREZ', 'ANDREA', ' ', ' ', ' ');
INSERT INTO Employees VALUES ('02', 'RAMIREZ', 'ANDRES', ' ', ' ', ' ');
INSERT INTO Employees VALUES ('03', 'SANCHEZ', 'CLAUDIO', ' ', ' ', ' ');
-----------------------------------Sección Juan Carlos-----------------------------------------------

-----------------------------------Sección Yeimi-----------------------------------------------