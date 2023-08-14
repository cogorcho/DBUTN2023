IF OBJECT_ID('genupdate', 'P') IS NOT NULL
DROP PROCEDURE genupdate
GO

create procedure genupdate
@tab varchar(128)
AS
BEGIN
    DECLARE @SALIDA TABLE (Texto VARCHAR(2048))
    DECLARE @SQLTEXT VARCHAR(1024)
    DECLARE @WHERE VARCHAR(1024)
    DECLARE C_COL CURSOR FOR
    SELECT 
        UPPER(c.name), 
        CASE y.name
            WHEN 'VARCHAR' then 'VARCHAR(' + TRIM(STR(c.MAX_LENGTH)) + ')'
            WHEN 'CHAR' then 'CHAR(' + TRIM(STR(c.MAX_LENGTH)) + ')'
            ELSE UPPER(y.name)
        END,
        i.is_primary_key
    FROM sys.tables t
        INNER JOIN sys.columns c
	        ON c.object_id = t.object_id
        INNER JOIN sys.types y
            ON y.user_type_id = c.user_type_id
        LEFT JOIN sys.index_columns ic
        	on ic.object_id = t.object_id
        	and ic.column_id = c.column_id
        LEFT JOIN sys.indexes i
        	ON i.object_id = t.object_id
        	and i.index_id = ic.index_id
    WHERE t.name = @tab

    DECLARE @COLNAME VARCHAR(128)
    DECLARE @COLTYPE VARCHAR(128)
    DECLARE @ISPK INT
    DECLARE @CNT INTEGER


    INSERT INTO @SALIDA VALUES ('IF OBJECT_ID(' + CHAR(39) + 'U_' + @tab + CHAR(39) + ',' + CHAR(39) + 'P' + CHAR(39) + ') IS NOT NULL')
    INSERT INTO @SALIDA VALUES ('    DROP PROCEDURE U_' + @tab)
    INSERT INTO @SALIDA VALUES ('GO')
    INSERT INTO @SALIDA VALUES ('')
    INSERT INTO @SALIDA VALUES ('CREATE PROCEDURE U_' + @tab)
    OPEN C_COL
    FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    SET @CNT = 0
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN
            IF @CNT = 0
                BEGIN
                    INSERT INTO @SALIDA VALUES ('    @' + @COLNAME + ' ' + @COLTYPE )
                    SET @CNT = 1
                END
            ELSE
                    INSERT INTO @SALIDA VALUES ('   ,@' + @COLNAME + ' ' + @COLTYPE )
        END    
        FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    END
    CLOSE C_COL

    INSERT INTO @SALIDA VALUES ('AS')
    INSERT INTO @SALIDA VALUES ('BEGIN')
    INSERT INTO @SALIDA VALUES ('  BEGIN TRY')
    INSERT INTO @SALIDA VALUES ('    UPDATE ' + @tab + ' SET')
    SET @CNT = 0
    OPEN C_COL
    FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @ISPK = 1
            BEGIN
                SET @WHERE = '    WHERE ' + UPPER(@COLNAME) + ' = ' + @COLNAME 
            END
        ELSE
            IF @CNT = 0
                BEGIN
                    INSERT INTO @SALIDA VALUES ('    ' + @COLNAME + ' = ISNULL(@' + @COLNAME + ', ' + @COLNAME + ')')
                    SET @CNT = 1
                END
            ELSE
                  INSERT INTO @SALIDA VALUES ('   ,' + @COLNAME + ' = ISNULL(@' + @COLNAME + ', ' + @COLNAME + ')' )

        FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    END
    INSERT INTO @SALIDA VALUES (@WHERE)
    CLOSE C_COL
    DEALLOCATE C_COL
    INSERT INTO @SALIDA VALUES ('  END TRY')
    INSERT INTO @SALIDA VALUES ('  BEGIN CATCH')
    INSERT INTO @SALIDA VALUES ('     EXECUTE GetErrorInfo_sp')
    INSERT INTO @SALIDA VALUES ('  END CATCH')
    INSERT INTO @SALIDA VALUES ('END')
    INSERT INTO @SALIDA VALUES ('GO')
    SELECT Texto FROM @SALIDA
END
GO