USE Northwind
GO

/*Realizar el CRUD de cada tabla dentro de las secciones correcpondientes*/
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
/*CORREGIR ELIMINACION EN CASCADA EMPLOYEES CON EMPLOYEETERRITORIES*/
create proc sp_delete_employees
@EmployeeID int
as
	Delete from Employees where EmployeeID = @EmployeeID;
go

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
