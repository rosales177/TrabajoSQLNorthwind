USE Northwind
GO

/*Realizar el CRUD de cada tabla dentro de las secciones correcpondientes*/

/*Restricciones delete  cascade*/

ALTER TABLE CustomerCustomerDemo
DROP CONSTRAINT IF EXISTS Fk_CustomerCustomerDemo_CustomerDemographics_Cascade_Delete
GO
ALTER TABLE CustomerCustomerDemo
ADD CONSTRAINT Fk_CustomerCustomerDemo_CustomerDemographics_Cascade_Delete FOREIGN KEY (CustomerTypeID)
REFERENCES CustomerDemographics (CustomerTypeID)
ON DELETE CASCADE
GO

ALTER TABLE CustomerCustomerDemo
DROP CONSTRAINT IF EXISTS Fk_CustomerCustomerDemo_Customers_Cascade_Delete
GO
ALTER TABLE CustomerCustomerDemo
ADD CONSTRAINT Fk_CustomerCustomerDemo_Customers_Cascade_Delete FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID)
ON DELETE CASCADE
GO

ALTER TABLE Orders
DROP CONSTRAINT IF EXISTS Fk_Orders_Customers_Cascade_Delete
GO
ALTER TABLE Orders
ADD CONSTRAINT Fk_Orders_Customer_Cascade_Delete FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID)
ON DELETE CASCADE
GO

ALTER TABLE Orders
DROP CONSTRAINT IF EXISTS Fk_Orders_Shippers_Cascade_Delete
GO
ALTER TABLE Orders
ADD CONSTRAINT Fk_Orders_Shippers_Cascade_Delete FOREIGN KEY (ShipVia)
REFERENCES Shippers (ShipperID)
ON DELETE CASCADE
GO

ALTER TABLE Orders
DROP CONSTRAINT IF EXISTS Fk_Orders_Employees_Cascade_Delete
GO
ALTER TABLE Orders
ADD CONSTRAINT Fk_Orders_Employees_Cascade_Delete FOREIGN KEY (EmployeeID)
REFERENCES Employees (EmployeeID)
ON DELETE CASCADE
GO

ALTER TABLE EmployeeTerritories
DROP CONSTRAINT IF EXISTS Fk_EmployeeTerritories_Employees_Cascade_Delete
GO
ALTER TABLE EmployeeTerritories
ADD CONSTRAINT Fk_EmployeeTerritories_Employees_Cascade_Delete FOREIGN KEY (EmployeeID)
REFERENCES Employees (EmployeeID)
ON DELETE CASCADE
GO

ALTER TABLE EmployeeTerritories
DROP CONSTRAINT IF EXISTS Fk_EmployeeTerritories_Territories_Cascade_Delete
GO
ALTER TABLE EmployeeTerritories
ADD CONSTRAINT Fk_EmployeeTerritories_Territories_Cascade_Delete FOREIGN KEY (TerritoryID)
REFERENCES Territories (TerritoryID)
ON DELETE CASCADE
GO

ALTER TABLE Territories
DROP CONSTRAINT IF EXISTS Fk_Territories_Region_Cascade_Delete
GO
ALTER TABLE Territories
ADD CONSTRAINT Fk_Territories_Region_Cascade_Delete FOREIGN KEY (RegionID)
REFERENCES Region (RegionID)
ON DELETE CASCADE
GO

ALTER TABLE Products 
DROP CONSTRAINT IF EXISTS Fk_Products_Suppliers_Cascade_Delete
GO
ALTER TABLE Products
ADD CONSTRAINT Fk_Products_Suppliers_Cascade_Delete FOREIGN KEY (SupplierID)
REFERENCES Suppliers (SupplierID)
ON DELETE CASCADE
GO

ALTER TABLE Products 
DROP CONSTRAINT IF EXISTS Fk_Products_Categories_Cascade_Delete
GO
ALTER TABLE Products
ADD CONSTRAINT Fk_Products_Categories_Cascade_Delete FOREIGN KEY (CategoryID)
REFERENCES Categories (CategoryID)
ON DELETE CASCADE
GO

ALTER TABLE [Order Details]
DROP CONSTRAINT IF EXISTS Fk_OrderDetails_Products_Cascade_Delete
GO
ALTER TABLE [Order Details]
ADD CONSTRAINT Fk_OrderDetails_Products_Cascade_Delete FOREIGN KEY (ProductID)
REFERENCES Products (ProductID)
ON DELETE CASCADE
GO

ALTER TABLE [Order Details]
DROP CONSTRAINT IF EXISTS Fk_OrderDetails_Orders_Cascade_Delete
GO
ALTER TABLE [Order Details]
ADD CONSTRAINT Fk_OrderDetails_Orders_Cascade_Delete FOREIGN KEY (OrderID)
REFERENCES Orders (OrderID)
ON DELETE CASCADE
GO




-----------------------------------Sección Employees-----------------------------------------------
DROP PROC IF EXISTS sp_Update_Employees
GO

CREATE PROC sp_Update_Employees
@EmployeeID int,
@LastName nvarchar(20) ,
@FirstName nvarchar(10) ,
@Title nvarchar(30) ,
@TitleOfCourtesy nvarchar(25) ,
@BirthDate date ,
@HireDate date ,
@Address nvarchar(60) ,
@City nvarchar(15) ,
@Region nvarchar(15) ,
@PostalCode nvarchar(10) ,
@Country nvarchar(15) ,
@HomePhone nvarchar(24) ,
@Extension nvarchar(4),
@Photo image,
@Notes ntext,
@ReportsTo int,
@PhotoPath nvarchar(255)
as
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100); 
	IF (@EmployeeID is null or @EmployeeID = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmployeeID, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF (@LastName is null or LEN(@LastName)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @LastName, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF (@FirstName is null or LEN(@FirstName)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @FirstName, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@Title)>=31)
	BEGIN
		SET @Mensaje = 'Error en la variable @Title, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@TitleOfCourtesy)>=26)
	BEGIN
		SET @Mensaje = 'Error en la variable @TitleOfCourtesy, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@Address)>=61)
	BEGIN
		SET @Mensaje = 'Error en la variable @Address, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@City)>=16)
	BEGIN
		SET @Mensaje = 'Error en la variable @City, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@Region)>=16)
	BEGIN
		SET @Mensaje = 'Error en la variable @Region, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@PostalCode)>=11)
	BEGIN
		SET @Mensaje = 'Error en la variable @PostalCode, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@Country)>=16)
	BEGIN
		SET @Mensaje = 'Error en la variable @Country, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@HomePhone)>=25)
	BEGIN
		SET @Mensaje = 'Error en la variable @HomePhone, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@Extension)>=5)
	BEGIN
		SET @Mensaje = 'Error en la variable @Extension, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	IF (@ReportsTo is null or @ReportsTo = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RepostsTo, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF (LEN(@PhotoPath)>=255)
	BEGIN
		SET @Mensaje = 'Error en la variable @PhotoPath, fuera de rango.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'El registro se actualizÃ³ correctamente.'
			UPDATE Employees SET
			[LastName] = @LastName,
			[FirstName] = @FirstName,
			[Title] = @Title,
			[TitleOfCourtesy] = @TitleOfCourtesy,
			[BirthDate] = @BirthDate,
			[HireDate] = @HireDate,
			[Address] = @Address,
			[City] = @City,
			[Region] = @Region,
			[PostalCode] = @PostalCode,
			[Country] = @Country,
			[HomePhone] = @HomePhone,
			[Extension] = @Extension,
			[Photo] = @Photo,
			[Notes] = @Notes,
			[ReportsTo] = @ReportsTo,
			[PhotoPath] = @PhotoPath
			WHERE 
			[EmployeeID] = @EmployeeID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacciÃ³n : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMenssage
		END CATCH

GO

DROP PROC IF EXISTS sp_delete_employees
go
create proc sp_delete_employees
@EmployeeID int
as
	Delete from Employees where EmployeeID = @EmployeeID;
go

EXEC sp_delete_employees 9

-----------------------------------Sección Orders-----------------------------------------------
-----------------------------------Sección Shippers-----------------------------------------------
-----------------------------------Sección EmployeeTerritories-----------------------------------------------
-----------------------------------Sección Customers-----------------------------------------------
-----------------------------------Sección CustomerCustomerDemo-----------------------------------------------
-----------------------------------Sección CustomerDemographic-----------------------------------------------
-----------------------------------Sección Suppliers-----------------------------------------------
-----------------------------------Sección Territories-----------------------------------------------
-----------------------------------Sección Regions-----------------------------------------------
-----------------------------------Sección Products-----------------------------------------------
-----------------------------------Sección Categories-----------------------------------------------
-----------------------------------Sección OrderDetails-----------------------------------------------

/*Realizar el CRUD de cada tabla dentro de las secciones correcpondientes*/

