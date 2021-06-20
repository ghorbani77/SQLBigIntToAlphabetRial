-- SQl BIGINT To Persian Alphabet/Rial Convertor 
--Ghorbani77@gmail.com
--Mohammad Ghorani
-- For Export : Use This
 
--DECLARE @Number BIGINT
--SET @Number = 989191437539
--SELECT dbo.Number2Letter(@Number)

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[R1_Digit]')
                    AND xtype IN ( N'FN', N'IF', N'TF' ) )
    DROP FUNCTION [dbo].[R1_Digit]
GO

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[R2_Digit]')
                    AND xtype IN ( N'FN', N'IF', N'TF' ) )
    DROP FUNCTION [dbo].[R2_Digit]
GO

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[R3_Digit]')
                    AND xtype IN ( N'FN', N'IF', N'TF' ) )
    DROP FUNCTION [dbo].[R3_Digit]
GO

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[Number2Letter]')
                    AND xtype IN ( N'FN', N'IF', N'TF' ) )
    DROP FUNCTION [dbo].[Number2Letter]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE FUNCTION [dbo].[R1_Digit] ( @Value SMALLINT )
RETURNS VARCHAR(5)
AS
    BEGIN -- FUNCTION
        DECLARE @Result VARCHAR(5)
        SET @Result = ( CASE @Value
                          WHEN 1 THEN 'Ìò '
                          WHEN 2 THEN 'œÊ '
                          WHEN 3 THEN '”Â '
                          WHEN 4 THEN 'çÂ«— '
                          WHEN 5 THEN 'Å‰Ã '
                          WHEN 6 THEN '‘‘ '
                          WHEN 7 THEN 'Â›  '
                          WHEN 8 THEN 'Â‘  '
                          WHEN 9 THEN '‰Â '
                          ELSE ''
                        END )
        RETURN @Result
    END
 -- FUNCTION

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE FUNCTION [dbo].[R2_Digit] ( @Value SMALLINT )
RETURNS VARCHAR(15)
AS
    BEGIN -- FUNCTION
        DECLARE @Result VARCHAR(15)
        DECLARE @N10 SMALLINT 
        DECLARE @N1 SMALLINT
        IF ( @Value <> 10 )
            BEGIN -- IF
                SET @N1 = @Value % 10
                SET @N10 = @Value - @N1        
            END -- IF
        SET @Result = ( CASE @Value
                          WHEN 10 THEN 'œÂ '
                          WHEN 11 THEN 'Ì«“œÂ '
                          WHEN 12 THEN 'œÊ«“œÂ '
                          WHEN 13 THEN '”Ì“œÂ '
                          WHEN 14 THEN 'çÂ«—œÂ '
                          WHEN 15 THEN 'Å«‰“œÂ '
                          WHEN 16 THEN '‘«‰“œÂ '
                          WHEN 17 THEN 'Â›œÂ '
                          WHEN 18 THEN 'ÂÃœÂ '
                          WHEN 19 THEN '‰Ê“œÂ '
                          WHEN 20 THEN '»Ì”  '
                          WHEN 30 THEN '”Ì '
                          WHEN 40 THEN 'çÂ· '
                          WHEN 50 THEN 'Å‰Ã«Â '
                          WHEN 60 THEN '‘’  '
                          WHEN 70 THEN 'Â› «œ '
                          WHEN 80 THEN 'Â‘ «œ '
                          WHEN 90 THEN '‰Êœ '
                          ELSE ( SELECT [dbo].[R2_Digit](@N10)
                               ) + 'Ê ' + ( SELECT  [dbo].[R1_Digit](@N1)
                                          )
                        END )
        RETURN @Result
    END
 -- FUNCTION

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE FUNCTION [dbo].[R3_Digit] ( @Value SMALLINT )
RETURNS VARCHAR(30)
AS
    BEGIN -- FUNCTION
        DECLARE @Result VARCHAR(30)
        DECLARE @N100 SMALLINT
        DECLARE @N10 SMALLINT
        SET @N10 = @Value % 100
        SET @N100 = @Value - @N10
        SET @Result = ( CASE @Value
                          WHEN 100 THEN 'Ìò’œ '
                          WHEN 200 THEN 'œÊÌ”  '
                          WHEN 300 THEN '”Ì’œ '
                          WHEN 400 THEN 'çÂ«—’œ '
                          WHEN 500 THEN 'Å«‰’œ '
                          WHEN 600 THEN '‘‘’œ '
                          WHEN 700 THEN 'Â› ’œ '
                          WHEN 800 THEN 'Â‘ ’œ '
                          WHEN 900 THEN '‰Â’œ '
                          ELSE CASE WHEN @N10 >= 10
                                    THEN ( SELECT   [dbo].[R3_Digit](@N100)
                                         ) + 'Ê '
                                         + ( SELECT [dbo].[R2_Digit](@N10)
                                           )
                                    ELSE ( SELECT   [dbo].[R3_Digit](@N100)
                                         ) + 'Ê '
                                         + ( SELECT [dbo].[R1_Digit](@N10)
                                           )
                               END
                        END )
        RETURN @Result
    END
 -- FUNCTION

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION [dbo].[Number2Letter] ( @Value BIGINT )
RETURNS VARCHAR(255)
AS
    BEGIN -- FUNCTION
        DECLARE @Number VARCHAR(15)
        DECLARE @N2L VARCHAR(255)
        DECLARE @Temp SMALLINT
        DECLARE @I TINYINT
        DECLARE @L TINYINT
        DECLARE @TL TINYINT
        DECLARE @TN SMALLINT
        DECLARE @P3D TABLE
            (
              ID TINYINT IDENTITY(1, 1) ,
              Number SMALLINT
            )
        INSERT  INTO @P3D
                ( Number )
        VALUES  ( 0 )
        INSERT  INTO @P3D
                ( Number )
        VALUES  ( 0 )
        INSERT  INTO @P3D
                ( Number )
        VALUES  ( 0 )
        INSERT  INTO @P3D
                ( Number )
        VALUES  ( 0 )
        SET @N2L = ''
        SET @Number = CAST(@Value AS VARCHAR(15))
        SET @L = LEN(@Number)
        SET @I = 0
        WHILE @I < @L
            BEGIN -- WHILE
                SET @I = @I + 3
                SET @Temp = 0
                SET @Temp = CAST(LEFT(RIGHT('000' + @Number, @I), 3) AS SMALLINT)
                UPDATE  @P3D
                SET     Number = @Temp
                WHERE   ID = ( @I / 3 )
            END -- WHILE
           
        SET @I = 4
        WHILE @I >= 1
            BEGIN -- WHILE
                SET @TN = ( SELECT  Number
                            FROM    @P3D
                            WHERE   ID = @I
                          )
                SET @TL = LEN(CAST(@TN AS VARCHAR(5)))    
                IF @TL = 1
                    SET @N2L = @N2L + ( SELECT  [dbo].[R1_Digit](@TN)
                                      )
                IF @TL = 2
                    SET @N2L = @N2L + ( SELECT  [dbo].[R2_Digit](@TN)
                                      )
                IF @TL = 3
                    SET @N2L = @N2L + ( SELECT  [dbo].[R3_Digit](@TN)
                                      )
             
                IF @TN <> 0
                    BEGIN -- IF
                        IF @I = 1
                            SET @N2L = @N2L + ''
                        IF @I = 2
                            BEGIN -- IF
                                IF ( SELECT Number
                                     FROM   @P3D
                                     WHERE  ID = @I - 1
                                   ) <> 0
                                    SET @N2L = @N2L + 'Â“«— Ê '
                                ELSE
                                    SET @N2L = @N2L + 'Â“«— '
                            END -- IF
                        IF @I = 3
                            BEGIN -- IF
                                IF ( SELECT Number
                                     FROM   @P3D
                                     WHERE  ID = @I - 1
                                   ) <> 0
                                    SET @N2L = @N2L + '„Ì·ÌÊ‰ Ê '
                                ELSE
                                    BEGIN -- ELSE
                                        IF ( SELECT Number
                                             FROM   @P3D
                                             WHERE  ID = @I - 2
                                           ) <> 0
                                            SET @N2L = @N2L + '„Ì·ÌÊ‰ Ê '
                                        ELSE
                                            SET @N2L = @N2L + '„Ì·ÌÊ‰ '
                                    END -- ELSE
                            END -- IF
                        IF @I = 4
                            BEGIN -- IF
                                IF ( SELECT Number
                                     FROM   @P3D
                                     WHERE  ID = @I - 1
                                   ) <> 0
                                    SET @N2L = @N2L + '„Ì·Ì«—œ Ê '
                                ELSE
                                    BEGIN -- ELSE
                                        IF ( SELECT Number
                                             FROM   @P3D
                                             WHERE  ID = @I - 2
                                           ) <> 0
                                            SET @N2L = @N2L + '„Ì·Ì«—œ Ê '
                                        ELSE
                                            BEGIN -- ELSE
                                                IF ( SELECT Number
                                                     FROM   @P3D
                                                     WHERE  ID = @I - 3
                                                   ) <> 0
                                                    SET @N2L = @N2L
                                                        + '„Ì·Ì«—œ Ê '
                                                ELSE
                                                    SET @N2L = @N2L
                                                        + '„Ì·Ì«—œ '
                                            END -- ELSE
                                    END -- ELSE
                            END -- IF  
                    END -- IF
                SET @I = @I - 1 
            END -- WHILE
        RETURN @N2L
    END
 -- FUNCTION

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
