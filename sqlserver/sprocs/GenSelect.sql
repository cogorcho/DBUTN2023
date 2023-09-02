IF OBJECT_ID('genselect', 'P') IS NOT NULL
DROP PROCEDURE genselect
GO

create procedure genselect
@tab varchar(128)
AS
BEGIN
    DECLARE @SALIDA TABLE (Texto VARCHAR(2048))
    DECLARE @SQLTEXT VARCHAR(1024)
    DECLARE @VALUES VARCHAR(1024)
    DECLARE @WHERE VARCHAR(1024)
    DECLARE C_COL CURSOR FOR
    select t.name, c.column_id ,c.name, ic.index_id, i.name, i.is_unique 
    from sys.tables t
    inner join sys.columns c 
        on c.object_id = t.object_id 
    inner join sys.index_columns ic
        on ic.object_id = c.object_id 
        and ic.column_id = c.column_id 
    inner join sys.indexes i
        on i.object_id = ic.object_id 
        and i.index_id = ic.index_id 
    where t.name = @tab

    DECLARE @COLNAME VARCHAR(128)
    DECLARE @COLTYPE VARCHAR(128)
    DECLARE @ISPK INT
    DECLARE @CNT INTEGER


    INSERT INTO @SALIDA VALUES ('IF OBJECT_ID(' + CHAR(39) + 'S_' + @tab + CHAR(39) + ',' + CHAR(39) + 'P' + CHAR(39) + ') IS NOT NULL')
    INSERT INTO @SALIDA VALUES ('    DROP PROCEDURE IS' + @tab)
    INSERT INTO @SALIDA VALUES ('GO')
    INSERT INTO @SALIDA VALUES ('')
    INSERT INTO @SALIDA VALUES ('CREATE PROCEDURE S_' + @tab)
    
    OPEN C_COL
    FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    SET @CNT = 0
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN
            IF @ISPK = 1
            BEGIN
                IF @CNT = 0
                    BEGIN
                        INSERT INTO @SALIDA VALUES ('    @' + @COLNAME + ' ' + @COLTYPE + ' OUTPUT' )
                        SET @CNT = 1
                    END
                ELSE
                        INSERT INTO @SALIDA VALUES ('   ,@' + @COLNAME + ' ' + @COLTYPE + ' OUTPUT')
            END
            ELSE
            BEGIN
                IF @CNT = 0
                    BEGIN
                        INSERT INTO @SALIDA VALUES ('    @' + @COLNAME + ' ' + @COLTYPE )
                        SET @CNT = 1
                    END
                ELSE
                        INSERT INTO @SALIDA VALUES ('   ,@' + @COLNAME + ' ' + @COLTYPE )
            END            
        END    
        FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    END
    CLOSE C_COL

    INSERT INTO @SALIDA VALUES ('AS')
    INSERT INTO @SALIDA VALUES ('BEGIN')
    INSERT INTO @SALIDA VALUES ('  BEGIN TRY')
    INSERT INTO @SALIDA VALUES ('    INSERT INTO ' + @tab)
    SET @CNT = 0
    OPEN C_COL
    FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @ISPK = 1
            BEGIN
                SET @WHERE = '    WHERE ' + UPPER(@COLNAME) + ' = @' + @COLNAME
            END
        ELSE
            IF @CNT = 0
                BEGIN
                    SET @SQLTEXT = '    (' + UPPER(@COLNAME)
                    SET @VALUES =  '    (@' + UPPER(@COLNAME)
                    SET @CNT = 1
                END
            ELSE
                BEGIN
                    SET @SQLTEXT = @SQLTEXT + ', ' + UPPER(@COLNAME)
                    SET @VALUES =  @VALUES + ', @' + UPPER(@COLNAME)
                END
        FETCH C_COL INTO @COLNAME, @COLTYPE, @ISPK
    END
    SET @SQLTEXT = @SQLTEXT + ')'
    SET @VALUES = @VALUES + ')'
    INSERT INTO @SALIDA VALUES (@SQLTEXT)
    INSERT INTO @SALIDA VALUES ('    VALUES')
    INSERT INTO @SALIDA VALUES (@VALUES)
    CLOSE C_COL
    DEALLOCATE C_COL
    INSERT INTO @SALIDA VALUES ('')
    INSERT INTO @SALIDA VALUES ('    SET @ID = @@IDENTITY')
    INSERT INTO @SALIDA VALUES ('  END TRY')
    INSERT INTO @SALIDA VALUES ('  BEGIN CATCH')
    INSERT INTO @SALIDA VALUES ('     EXECUTE GetErrorInfo_sp')
    INSERT INTO @SALIDA VALUES ('  END CATCH')
    INSERT INTO @SALIDA VALUES ('END')
    INSERT INTO @SALIDA VALUES ('GO')

    SELECT Texto FROM @SALIDA
END
GO
