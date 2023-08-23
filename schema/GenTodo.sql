IF OBJECT_ID('gentodo', 'P') IS NOT NULL
DROP PROCEDURE gentodo
GO

create procedure gentodo
AS
BEGIN
    DECLARE @TABNAME VARCHAR(1024)
    DECLARE C_TABS CURSOR FOR SELECT UPPER(name) FROM sys.tables
    CREATE TABLE #TEMPTAB (data varchar(2048))

    OPEN C_TABS
    FETCH C_TABS INTO @TABNAME
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO #TEMPTAB(data) VALUES ('---------------------------------------')
        INSERT INTO #TEMPTAB(data) VALUES (CONCAT('-- TABLA: ',  @TABNAME, '   ----------------'))      
        INSERT INTO #TEMPTAB(data) VALUES ('---------------------------------------')
        INSERT INTO #TEMPTAB EXEC GenDelete @tab=@TABNAME
        INSERT INTO #TEMPTAB EXEC GenInsert @tab=@TABNAME
        INSERT INTO #TEMPTAB EXEC GenUpdate @tab=@TABNAME

        FETCH C_TABS INTO @TABNAME
    END
    CLOSE C_TABS
    DEALLOCATE C_TABS
    SELECT data FROM #TEMPTAB
END
GO