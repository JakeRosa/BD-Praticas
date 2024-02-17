# BD: Guião 9


## ​9.1
 
### *a)*

```sql
CREATE PROCEDURE removeEmployee
    @Ssn varchar(10)
AS 
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dependent] WHERE Essn = @Ssn;
        DELETE FROM Works_on WHERE Essn = @Ssn;
        DELETE FROM Employee WHERE Ssn = @Ssn;
    -- Se todas as operações foram bem-sucedidas, confirma a transação
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error'
    END CATCH;
END;
```
```txt
    Melhorar a performance: Evitando o envio dessas mensagens, é possível reduzir a quantidade de tráfego de rede entre o servidor e o cliente, o que pode melhorar a performance de suas queries, principalmente se você estiver fazendo muitas operações que afetam muitas linhas.

    Evitar confusão: Em alguns casos, essas mensagens podem confundir o cliente ou a aplicação que está chamando a stored procedure ou trigger. Por exemplo, se uma stored procedure inclui várias instruções que modificam tabelas, o cliente pode receber várias mensagens indicando a quantidade de linhas afetadas. Se o cliente estiver esperando apenas um conjunto de resultados, essas mensagens extras podem causar confusão. Ao usar SET NOCOUNT ON, você pode evitar esse problema.  
```

### *b)* 

```sql
CREATE PROCEDURE getManagerInfo
AS
BEGIN
    -- Obtém a data atual
    DECLARE @currentDate AS DATE = GETDATE();

    -- Cria uma tabela temporária para armazenar os dados dos gestores
    CREATE TABLE #ManagerInfo
    (
        Ssn VARCHAR(10),
        YearsOfService AS DATEDIFF(YEAR, Mgr_start_date, @currentDate)
    );

    -- Insere os dados dos gestores na tabela temporária
    INSERT INTO #ManagerInfo (Ssn)
    SELECT Mgr_snn FROM Department WHERE Mgr_snn IS NOT NULL;

    -- Obtém os dados dos gestores
    SELECT E.Fname, E.Minit, E.LName, E.Ssn, D.Mgr_snn, MI.YearsOfService
    FROM Employee E
    INNER JOIN Department D ON E.Ssn = D.Mgr_snn
    INNER JOIN #ManagerInfo MI ON E.Ssn = MI.Ssn;

    -- Obtém o ssn e número de anos do gestor mais antigo
    SELECT TOP 1 Ssn, YearsOfService
    FROM #ManagerInfo
    ORDER BY YearsOfService DESC;

    -- Remove a tabela temporária
    DROP TABLE #ManagerInfo;
END;
```

### *c)* 

```sql
CREATE TRIGGER checkManagerDepartment ON Department
FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

	
    DECLARE @Mgr_Ssn varchar(10);
	DECLARE @Dnumber INT;
    -- Obter o SSN do gestor do departamento que está sendo inserido ou atualizado
    SELECT @Mgr_Ssn = post.Mgr_Ssn FROM inserted post, @Dnumber = post.Dnumber
	from inserted post;


	-- Verificar se esse gestor já gerencia um departamento
	IF EXISTS (SELECT * FROM Department WHERE Mgr_snn = @Mgr_Ssn AND Dnumber <> @Dnumber))
    BEGIN
        RAISERROR ('Manager already exists', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
```

### *d)* 

```sql
CREATE TRIGGER SalaryCheck
ON Employee
AFTER UPDATE
AS
BEGIN
    -- Para a linha que foi atualizada
    DECLARE @ssn VARCHAR(10);
    DECLARE @dno INT;
    DECLARE @salary DECIMAL(6, 2);
    DECLARE @managerSalary DECIMAL(6, 2);

    SELECT TOP 1 @ssn = Ssn, @dno = Dno, @salary = Salary FROM inserted;

    -- Encontra o salário do gestor do departamento do funcionário
    SELECT @managerSalary = Salary 
    FROM Employee 
    WHERE Ssn = (SELECT Mgr_snn FROM Department WHERE Dnumber = @dno);

    -- Se o salário do funcionário é maior que o do gestor
    IF @salary > @managerSalary
    BEGIN
        -- Ajusta o salário do funcionário para ser um menos que o do gestor
        UPDATE Employee
        SET Salary = @managerSalary - 1
        WHERE Ssn = @ssn;
    END;
END
```

### *e)* 

```sql
CREATE FUNCTION employeeProjects(@Ssn VARCHAR(10)) RETURNS TABLE 
AS
RETURN
(
	SELECT P.Pname, P.Plocation
	FROM Project P
	INNER JOIN Works_on W ON P.Pnumber = W.Pno
	WHERE W.Essn = @Ssn
);

GO
SELECT * FROM employeeProjects('183623612');
```

### *f)* 

```sql
CREATE FUNCTION GetEmployeesAboveAverageSalary(@Dno INT = 0) 
RETURNS TABLE
AS
	RETURN (
		SELECT E.Fname, E.Minit, E.Lname, E.Ssn, E.Salary
		FROM Employee E
		WHERE E.Salary > (SELECT AVG(Salary) FROM Employee WHERE Dno = @Dno)
	);	
GO
```

### *g)* 

```sql
CREATE FUNCTION dbo.getDepartmentProjects (@Dno INT)
RETURNS @ProjectInfo TABLE
(
    Pnumber INT,
    Pname VARCHAR(30),
    MonthlyLaborBudget DECIMAL(10,2),
    AccumulatedBudget DECIMAL(10,2)
)
AS
BEGIN
    DECLARE @Pnumber INT, @Pname VARCHAR(30), @EmployeeSalary DECIMAL(10,2), @MonthlyLaborBudget DECIMAL(10,2), @AccumulatedBudget DECIMAL(10,2);

    SET @AccumulatedBudget = 0;

    DECLARE project_cursor CURSOR FOR 
    SELECT p.Pnumber, p.Pname, e.Salary
    FROM Project p
    JOIN Works_on w ON p.Pnumber = w.Pno
    JOIN Employee e ON w.Essn = e.Ssn
    WHERE p.Dnum = @Dno;

    OPEN project_cursor;

    FETCH NEXT FROM project_cursor INTO @Pnumber, @Pname, @EmployeeSalary;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Calculating Monthly Labor Budget (assuming 4 weeks in a month and 40 hours per week)
        SET @MonthlyLaborBudget = @EmployeeSalary / (4 * 40);
        SET @AccumulatedBudget = @AccumulatedBudget + @MonthlyLaborBudget;

        INSERT INTO @ProjectInfo (Pnumber, Pname, MonthlyLaborBudget, AccumulatedBudget)
        VALUES (@Pnumber, @Pname, @MonthlyLaborBudget, @AccumulatedBudget);

        FETCH NEXT FROM project_cursor INTO @Pnumber, @Pname, @EmployeeSalary;
    END;

    CLOSE project_cursor;
    DEALLOCATE project_cursor;

    RETURN;
END;

SELECT * FROM dbo.getDepartmentProjects(3);
```

### *h)* 

```sql
-- Trigger AFTER
CREATE TRIGGER DeleteDepartment ON Department
AFTER DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Department_Deleted')
    BEGIN
        SELECT * INTO Department_Deleted FROM DEPARTMENT; WHERE 1 = 2;
    END

    INSERT INTO Department_Deleted
    SELECT * FROM deleted;
END
GO

-- Trigger INSTEAD OF
CREATE TRIGGER DeleteDepartment ON Department
INSTEAD OF DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Department_Deleted')
    BEGIN
        SELECT * INTO Department_Deleted FROM DEPARTMENT; WHERE 1 = 2;
    END

    INSERT INTO Department_Deleted
    SELECT * FROM deleted;

    DELETE FROM Department WHERE Dnumber IN (SELECT Dnumber FROM deleted);
END
```
```mk
    Trigger After
        Vantagem:
        
        A vantagem de usar um trigger AFTER é que ele garante que a operação de DML foi bem-sucedida antes de executar qualquer ação adicional. Isso pode ser útil se as ações adicionais dependerem do sucesso da operação de DML.
        Desvantagem:

        A desvantagem de usar um trigger AFTER é que ele não pode ser usado para substituir a operação de DML. Se você precisar substituir a operação de DML, deverá usar um trigger INSTEAD OF.

    Trigger Instead Of
        Vantagem:

            A vantagem de usar um trigger INSTEAD OF é que ele pode ser usado para substituir a operação de DML. Isso pode ser útil se você precisar substituir a operação de DML.
        Desvantagem:

            A desvantagem de usar um trigger INSTEAD OF é que ele não garante que a operação de DML foi bem-sucedida antes de executar qualquer ação adicional. Isso pode ser um problema se as ações adicionais dependerem do sucesso da operação de DML. 
```

### *i)* 

```
As stored procedures podem retornar zero, um ou múltiplos valores enquanto as UDFs podem retornar um único valor (escalar) ou uma tabela de valores. As stored procedures podem ter parâmetros de entrada e saída, enquanto as UDFs só podem ter de entrada. Nas stored procedures não se pode usar comandos SELECT, WHERE e HAVING enquanto que nas UDF pode-se. As stored procedures permitem usar chamar outras stored procedures, permitem tratamento de exceções com blocos TRY/CATCH e podem iniciar, cometer ou reverter transações, enquanto que as UDFs não permitem nada disto.

É vantajoso usar as stored procedures quando é preciso executar queries complexas repetidamente, visto que estas são pré-compiladas e guardadas na base de dados.

```