USE Northwind
GO

/*Realizar el CRUD de cada tabla dentro de las secciones correcpondientes*/

/*Restricciones delete  cascade*/

ALTER TABLE Customers 
DROP CONSTRAINT IF EXISTS Fk_Customers_CustomerCustomerDemo_Cascade_Delete

ALTER TABLE Customers
ADD CONSTRAINT Fk_Customers_CustomerCustomerDemo_Cascade_Delete FOREIGN KEY (customerID)
REFERENCES CustomerCustomerDemo(customerID)
ON DELETE CASCADE
GO

ALTER TABLE Customers 
DROP CONSTRAINT IF EXISTS Fk_Customers_Orders_Cascade_Delete

ALTER TABLE Customers
ADD CONSTRAINT Fk_Customers_Orders_Cascade_Delete FOREIGN KEY (order_ID)
REFERENCES Orders(customerID)
ON DELETE CASCADE
GO

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

ALTER TABLE CustomerDemographics
DROP CONSTRAINT IF EXISTS Fk_CustomerDemographics_CustomerCustomerDemo_Cascade_Delete
GO
ALTER TABLE CustomerDemographics
ADD CONSTRAINT Fk_CustomerDemographics_CustomerCustomerDemo_Cascade_Delete FOREIGN KEY (CustomerID)
REFERENCES CustomerCustomerDemo (CustomerID)
ON DELETE CASCADE
GO

ALTER TABLE Orders
DROP CONSTRAINT IF EXISTS Fk_Orders_Customer_Cascade_Delete
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




-----------------------------------Seccion Employees-----------------------------------------------
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
			SET @Mensaje = 'El registro se actualizo correctamente.'
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
			SET @Mensaje = 'Error en la transaccion : '
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


-----------------------------------Seccion Orders-----------------------------------------------
-----------------------------------Seccion Shippers-----------------------------------------------
DROP PROC IF EXISTS sp_insert_shippers
go
CREATE PROC sp_insert_shippers
	@ShipperID int ,
	@CompanyName nvarchar(40),
	@Phone nvarchar(24)
	
	
as
declare @resultado varchar(50) 
	SET NOCOUNT ON;

	if @Phone is null or len(@phone)>6 or len(@phone)<10
	begin
		set @resultado = '@phone no valido o fuera de rango'
		print @resultado
		return
	end
	IF @CompanyName is null or len(@CompanyName)=0
	begin
		set @resultado = '@CompanyName no valido'
		print @resultado
		return
	end
	
	BEGIN TRY 

		INSERT INTO Shippers( ShipperID, CompanyName, Phone)
		values(@ShipperID,@CompanyName, @Phone)
		set @resultado = 'Datos insertados'
		print @resultado
		commit tran
	end TRY
	begin catch
		SET @resultado = 'error de datos'
		rollback tran
			select ERROR_MESSAGE() as ErrorMessage
	end catch


go


DROP PROC IF EXISTS sp_update_shippers
go
CREATE PROC sp_update_shippers
	@ShipperID int ,
	@CompanyName nvarchar(40) ,
	@Phone nvarchar(24)
as
declare @resultado nvarchar(50)
	SET NOCOUNT ON;
	if @Phone is null or len(@phone)>6 or len(@phone)<10
	begin
		set @resultado = '@phone no valido o fuera de rango'
		print @resultado
		return
	end
	IF @CompanyName is null or len(@CompanyName)=0
	begin
		set @resultado = '@CompanyName no valido'
		print @resultado
		return
	end

	BEGIN TRY
	
		UPDATE Shippers set
			CompanyName = @CompanyName,
			Phone = @Phone
		Where ShipperID = @ShipperID

		Set @resultado='Datos Actualizados'
		print @resultado
		commit tran
	end try
	begin catch
		set @resultado = 'Error en los datos'
		rollback tran
			Select ERROR_MESSAGE() as ErrorMessage
	end catch

go

DROP PROC IF EXISTS sp_delete_shippers
go
CREATE PROC sp_delete_shippers
	@ShipperID int 
as
declare @resultado nvarchar(50)

	SET NOCOUNT ON;
	if @ShipperID is null or len(@ShipperID)=0
	Begin
		set @resultado ='Error al resultado'
		print @resultado
		return
	end
	begin try
				DELETE FROM Shippers Where ShipperID = @ShipperID
				set @resultado = 'Datos eliminados'
				print @resultado
				commit tran
	end try

	Begin catch
			Set @resultado='Hubo un error'
			print @resultado
			Rollback tran
			SELECT
				ERROR_MESSAGE() AS ErrorMessage;


	END CATCH;
go


DROP PROC IF EXISTS sp_select_shippersID
go
CREATE PROC sp_select_shippersID
	@ShipperID int 
as
declare @resultado nvarchar(50)

	SET NOCOUNT ON;
	if @ShipperID is null or LEN(@ShipperID)=0
	begin
		set @resultado = 'Error al dato'
		print @resultado
		return
	end
	Begin try
		
		SELECT CompanyName, Phone FROM Shippers 
		Where ShipperID = @ShipperID
		Commit tran
	end try

	Begin catch
		set @resultado = 'Error a la vista'
		print @resultado
		select 
		ERROR_MESSAGE () as ErrorMessage,
		ERROR_SEVERITY() AS ErrorSeverity
	end catch
go

Create View cv_select_shippers
as
	Select ShipperID, CompanyName, Phone From Shippers

go




-----------------------------------Seccion EmployeeTerritories-----------------------------------------------
-----------------------------------Seccion Customers-----------------------------------------------

DROP PROC IF EXISTS sp_Insert_Customers 
GO
CREATE PROC sp_Insert_Customers
@company_name nvarchar(50),
@contact_name nvarchar(50),
@contact_title nvarchar(50),
@address nvarchar(60),
@city nvarchar(20),
@region nvarchar(20),
@postal_code nvarchar(15),
@country nvarchar(20),
@phone nvarchar(9),
@fax nvarchar(30)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@company_name is null or LEN(@company_name) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @company_name, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO Suppliers ([companyname],[contactname],[contacttitle],[address],[city],[region],[postalcode],[country],[phone],[fax])
			VALUES (@company_name,@contact_name,@contact_title,@address,@city,@region,@postal_code,@country,@phone,@fax)
			PRINT @Mensaje 
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Update_Customers
GO
CREATE PROC sp_Update_Customers
@customerID int,
@company_name nvarchar(50),
@contact_name nvarchar(50),
@contact_title nvarchar(50),
@address nvarchar(60),
@city nvarchar(20),
@region nvarchar(20),
@postal_code nvarchar(15),
@country nvarchar(20),
@phone nvarchar(9),
@fax nvarchar(30)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@customerID is null or LEN(@customerID)= 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @customerID,fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@company_name is null or LEN(@company_name) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @company_name, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Actualizados Correctamente'
			UPDATE Customers SET
			[Companyname] = @company_name,
			[contactname] = @contact_name,
			[contacttitle] = @contact_title,
			[address]  = @address,
			[city] = @city,
			[region] = @region,
			[postalcode] = @postal_code,
			[country] = @country,
			[phone]  = @phone,
			[fax] = @fax
			WHERE 
			[customerID] = @customerID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMenssage
		END CATCH

GO

DROP PROC IF EXISTS sp_Delete_Customers
GO
CREATE PROC sp_Delete_Customers
@customerID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@customerID is null or LEN(@customerID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @customerID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Eliminados Correctamente'
			DELETE FROM Customers WHERE customerID = @customerID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH

GO

DROP PROC IF EXISTS sp_SelectWhereID_Customers
GO
CREATE PROC sp_SelectWhereID_Customers
@customerID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@customerID is null or LEN(@customerID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @customerID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT TOP 100 c.*  FROM Customers c WHERE c.customerID = @customerID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH

GO

DROP VIEW IF EXISTS vp_Select_Customers
GO
CREATE VIEW vp_Select_Customers
AS
	SELECT TOP 100 c.* FROM Customers c
GO

-----------------------------------Sección CustomerCustomerDemo-----------------------------------------------

DROP PROC IF EXISTS sp_Insert_CustomerCustomerDemo
GO

CREATE PROC sp_Insert_CustomerCustomerDemo
@CustomerID nvarchar(50),
@CustomerTypeID nvarchar(50)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@CustomerID is null or LEN(@CustomerID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @CustomerID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@CustomerTypeID is null or LEN(@CustomerTypeID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @CustomerTypeID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO CustomerCustomerDemo VALUES
			(@CustomerID,@CustomerTypeID)
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Update_CustomerCustomerDemo
GO
CREATE PROC sp_Update_CustomerCustomerDemo
@CustomerID nvarchar(50),
@CustomerTypeID nvarchar(50)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@CustomerID is null or LEN(@CustomerID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @CustomerID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@CustomerTypeID is null or LEN(@CustomerTypeID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @CustomerTypeID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Actualizados Correctamente'
			UPDATE CustomerCustomerDemo SET
			[CustomerTypeID] = @CustomerTypeID
			WHERE [CustomerID] = @CustomerID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Delete_CustomerCustomerDemo
GO
CREATE PROC sp_Delete_CustomerCustomerDemo
@CustomerID nvarchar(50)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@CustomerID is null or LEN(@CustomerID) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Eliminados Correctamente'
			DELETE FROM CustomerCustomerDemo WHERE CustomerID = @CustomerID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_SelectWhereID_CustomerCustomerDemo
GO
CREATE PROC sp_SelectWhereID_CustomerCustomerDemo
@CustomerID nvarchar(20)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@CustomerID is null or LEN(@CustomerID)=0)
	BEGIN
		SET @Mensaje = 'Error e la varible @CustomerID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT TOP 100 d.CustomerID,d.CustomerTypeID
			FROM CustomerCustomerDemo d
			WHERE d.CustomerID = @CustomerID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP VIEW IF EXISTS vp_Select_CustomerCustomerDemo
GO
CREATE VIEW vp_Select_CustomerCustomerDemo
AS
	SELECT TOP 100 d.CustomerID,d.CustomerTypeID
			FROM CustomerCustomerDemo d
	
GO
-----------------------------------Sección CustomerDemographic-----------------------------------------------

DROP PROC IF EXISTS sp_Insert_CustomerDemographics
GO
CREATE PROC sp_Insert_CustomerDemographics
@CustomerTypeID nvarchar(50),
@CustomerDesc nvarchar(50)
AS
	DECLARE @Mensaje nvarchar(100);
	SET NOCOUNT ON;
	IF(@CustomerTypeID is null or LEN(@CustomerTypeID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerTypeID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@CustomerDesc is null  or LEN(@CustomerDesc)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerDesc, fuera de rango o nulo.'
		PRINT @Mensaje 
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO CustomerDemographics VALUES
			(@CustomerTypeID, @CustomerDesc)
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO
DROP PROC IF EXISTS sp_Update_CustomerDemographics
GO
CREATE PROC sp_Update_CustomerDemographics
@CustomerTypeID nvarchar(50),
@CustomerDesc nvarchar(50)
AS
	DECLARE @Mensaje nvarchar(100);
	SET NOCOUNT ON;
	IF(@CustomerTypeID is null or LEN(@CustomerTypeID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerTypeID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@CustomerDesc is null  or LEN(@CustomerDesc)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerDesc, fuera de rango o nulo.'
		PRINT @Mensaje 
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Actualizados Correctamente'
			UPDATE CustomerDemographics SET
			[CustomerDesc] = @CustomerDesc
			WHERE [CustomerTypeID] = @CustomerTypeID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMenssage
		END CATCH
			
GO
DROP PROC IF EXISTS sp_Delete_CustomerDemographics
GO
CREATE PROC sp_Delete_CustomerDemographics
@CustomerTypeID nvarchar(50)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100);
	IF(@CustomerTypeID is null or LEN(@CustomerTypeID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerTypeID, fuera de rango o nulo.'
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Eliminados Correctamente'
			DELETE FROM CustomerDemographics WHERE @CustomerTypeID = @CustomerTypeID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO
DROP PROC IF EXISTS sp_SelectWhereID_CustomerDemographics
GO
CREATE PROC sp_SelectWhereID_CustomerDemographics
@CustomerTypeID int
AS
	SET NOCOUNT ON
	DECLARE @Mensaje nvarchar(100)
	IF(@CustomerTypeID is null or LEN(@CustomerTypeID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CustomerTypeID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT TOP 100 ct.CustomerTypeID,ct.CustomerDesc 
			FROM  CustomerDemographics ct
			WHERE ct.CustomerTypeID = @CustomerTypeID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO
DROP VIEW IF EXISTS vp_Select_CustomerDemographics
GO
CREATE VIEW vp_Select_CustomerDemographics
AS
			SELECT TOP 100 ct.CustomerTypeID,ct.CustomerDesc 
			FROM  CustomerDemographics ct
GO


-----------------------------------Sección Suppliers-----------------------------------------------

DROP PROC IF EXISTS sp_Insert_Suppliers
GO
CREATE PROC sp_Insert_Suppliers
@CompanyName nvarchar(40),
@ContactName nvarchar(30),
@ContactTitle nvarchar(30),
@Address nvarchar(60),
@City nvarchar(15),
@Region nvarchar(15),
@PostalCode nvarchar(10),
@Country nvarchar(15),
@Phone nvarchar(24),
@Fax nvarchar(24),
@HomePage ntext
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@CompanyName is null or LEN(@CompanyName) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CompanyName, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO Suppliers ([CompanyName],[ContactName],[ContactTitle],[Address],[City],[Region],[PostalCode],[Country],[Phone],[Fax],[HomePage])
			VALUES (@CompanyName,@ContactName,@ContactTitle,@Address,@City,@Region,@PostalCode,@Country,@Phone,@Fax,@HomePage)
			PRINT @Mensaje 
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Update_Suppliers
GO
CREATE PROC sp_Update_Suppliers
@SupplierID int,
@CompanyName nvarchar(40),
@ContactName nvarchar(30),
@ContactTitle nvarchar(30),
@Address nvarchar(60),
@City nvarchar(15),
@Region nvarchar(15),
@PostalCode nvarchar(10),
@Country nvarchar(15),
@Phone nvarchar(24),
@Fax nvarchar(24),
@HomePage ntext
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@SupplierID is null or LEN(@SupplierID)= 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SupplierID,fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@CompanyName is null or LEN(@CompanyName) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @CompanyName, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Actualizados Correctamente'
			UPDATE Suppliers SET
			[CompanyName] = @CompanyName,
			[ContactName] = @ContactName,
			[ContactTitle] = @ContactTitle,
			[Address]  = @Address,
			[City] = @City,
			[Region] = @Region,
			[PostalCode] = @PostalCode,
			[Country] = @Country,
			[Phone]  = @Phone,
			[Fax] = @Fax,
			[HomePage] = @HomePage
			WHERE [SupplierID] = @SupplierID
			PRINT @Mensaje 
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Delete_Suppliers
GO
CREATE PROC sp_Delete_Suppliers
@SupplierID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@SupplierID is null or LEN(@SupplierID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SupplierID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Eliminados Correctamente'
			DELETE FROM Suppliers WHERE SupplierID = @SupplierID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH

GO

DROP PROC IF EXISTS sp_SelectWhereID_Suppliers
GO
CREATE PROC sp_SelectWhereID_Suppliers
@SupplierID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@SupplierID is null or LEN(@SupplierID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SupplierID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT TOP 100 s.*  FROM Suppliers s WHERE s.SupplierID = @SupplierID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH

GO

DROP VIEW IF EXISTS vp_Select_Suppliers
GO
CREATE VIEW vp_Select_Suppliers
AS
	SELECT TOP 100 s.* FROM Suppliers s
GO

-----------------------------------Seccion Territories-----------------------------------------------

DROP PROC IF EXISTS sp_Insert_Territories
GO

CREATE PROC sp_Insert_Territories
@TerritoryID nvarchar(20),
@TerritoryDescription nvarchar(50),
@RegionID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@TerritoryID is null or LEN(@TerritoryID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @TerritoryID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@TerritoryDescription is null or LEN(@TerritoryDescription)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @TerritoryDescription, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@RegionID is null or LEN(@RegionID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @RegionID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO Territories VALUES
			(@TerritoryID,@TerritoryDescription,@RegionID)
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Update_Territories
GO
CREATE PROC sp_Update_Territories
@TerritoryID nvarchar(20),
@TerritoryDescription nvarchar(50),
@RegionID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@TerritoryID is null or LEN(@TerritoryID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @TerritoryID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@TerritoryDescription is null or LEN(@TerritoryDescription)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @TerritoryDescription, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@RegionID is null or LEN(@RegionID)=0)
	BEGIN
		SET @Mensaje  = 'Error en la variable @RegionID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Actualizados Correctamente'
			UPDATE Territories SET
			[TerritoryDescription] = @TerritoryDescription,
			[RegionID] = @RegionID
			WHERE [TerritoryID] = @TerritoryID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_Delete_Territories
GO
CREATE PROC sp_Delete_Territories
@TerritoryID nvarchar(20)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@TerritoryID is null or LEN(@TerritoryID) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @TerritoryID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Eliminados Correctamente'
			DELETE FROM Territories WHERE TerritoryID = @TerritoryID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP PROC IF EXISTS sp_SelectWhereID_Territories
GO
CREATE PROC sp_SelectWhereID_Territories
@TerritoryID nvarchar(20)
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100)
	IF(@TerritoryID is null or LEN(@TerritoryID)=0)
	BEGIN
		SET @Mensaje = 'Error e la varible @TerritoryID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT TOP 100 t.TerritoryID,t.TerritoryDescription,r.RegionDescription 'Region' 
			FROM Territories t JOIN Region r on (t.RegionID = r.RegionID)
			WHERE t.TerritoryID = @TerritoryID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO

DROP VIEW IF EXISTS vp_Select_Territories
GO
CREATE VIEW vp_Select_Territories
AS
	SELECT TOP 100 t.TerritoryID,t.TerritoryDescription,r.RegionDescription 'Region'
	FROM Territories t
	JOIN Region r on(t.RegionID = r.RegionID)
	
GO

-----------------------------------Seccion Regions-----------------------------------------------

DROP PROC IF EXISTS sp_Insert_Region
GO
CREATE PROC sp_Insert_Region
@RegionID int,
@RegionDescription nvarchar(50)
AS
	DECLARE @Mensaje nvarchar(100);
	SET NOCOUNT ON;
	IF(@RegionID is null or LEN(@RegionID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RegionID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@RegionDescription is null  or LEN(@RegionDescription)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RegionDescription, fuera de rango o nulo.'
		PRINT @Mensaje 
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO 
			Region (RegionID,RegionDescription)
			VALUES (@RegionID,@RegionDescription)
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMenssage
		END CATCH
			
GO
DROP PROC IF EXISTS sp_Update_Region
GO
CREATE PROC sp_Update_Region
@RegionID int,
@RegionDescription nvarchar(50)
AS
	DECLARE @Mensaje nvarchar(100);
	SET NOCOUNT ON;
	IF(@RegionID is null or LEN(@RegionID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RegionID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	IF(@RegionDescription is null  or LEN(@RegionDescription)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RegionDescription, fuera de rango o nulo.'
		PRINT @Mensaje 
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Actualizados Correctamente'
			UPDATE Region SET
			[RegionDescription] = @RegionDescription
			WHERE [RegionID] = @RegionID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMenssage
		END CATCH
			
GO
DROP PROC IF EXISTS sp_Delete_Region
GO
CREATE PROC sp_Delete_Region
@RegionID int
AS
	SET NOCOUNT ON;
	DECLARE @Mensaje nvarchar(100);
	IF(@RegionID is null or LEN(@RegionID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RegionID, fuera de rango o nulo.'
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Eliminados Correctamente'
			DELETE FROM Region WHERE RegionID = @RegionID
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO
DROP PROC IF EXISTS sp_SelectWhereID_Region
GO
CREATE PROC sp_SelectWhereID_Region
@RegionID int
AS
	SET NOCOUNT ON
	DECLARE @Mensaje nvarchar(100)
	IF(@RegionID is null or LEN(@RegionID)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @RegionID, fuera de rango o nulo.'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT TOP 100 r.RegionID,r.RegionDescription 
			FROM  Region r
			WHERE r.RegionID = @RegionID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la Transaccion : '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() as ErrorMessage
		END CATCH
GO
DROP VIEW IF EXISTS vp_Select_Region
GO
CREATE VIEW vp_Select_Region
as
	SELECT TOP 100 r.RegionID, r.RegionDescription FROM Region r
GO

-----------------------------------Seccion Products-----------------------------------------------
-----------------------------------Seccion Categories-----------------------------------------------
-----------------------------------Seccion OrderDetails-----------------------------------------------

/*Realizar el CRUD de cada tabla dentro de las secciones correcpondientes*/

