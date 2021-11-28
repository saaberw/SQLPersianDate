/****** Code by SABER VAHABI ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Miladi2Shamsi.sql] (@intDate  DateTime)  
RETURNS Varchar(10)
AS  
BEGIN 
----------------------------------------------------------------
  DECLARE @gy2  as int;
  DECLARE @days  as int;
  DECLARE @gy  as Int;
  DECLARE @gm  as INT;
  DECLARE @gd  as Int;
  DECLARE @jy  as Integer;
  DECLARE @jm  as Integer;
  DECLARE @jd  as Integer;
  DECLARE @gdm  as Integer;
  DECLARE @g_d_m varchar(50);  
  set @g_d_m = '0,31,59,90,120,151,181,212,243,273,304,334';
  
  SET @gy = DatePart(yyyy, @intDate)
    IF ( @gy < 1000 ) SET @gy = @gy + 2000
    SET @gm = Month(@intDate)
    SET @gd = Day(@intDate)
 
  If (@gm > 2 )
    set @gy2 = (@gy + 1);
  ELSE  
    set @gy2 = @gy;
  
   SELECT   @gdm= CASE @gm  
         WHEN 1 THEN 0  
         WHEN 2 THEN 31
         WHEN 3 THEN 59 
         WHEN 4 THEN 90
         WHEN 5 THEN 120  
         WHEN 6 THEN 151
         WHEN 7 THEN 181
         WHEN 8 THEN 212
         WHEN 9 THEN 243  
         WHEN 10 THEN 273
         WHEN 11 THEN 304
         WHEN 12 THEN 334
         ELSE 0
      END  
  set @days = 355666 + (365 * @gy) + ((@gy2 + 3) / 4) - ((@gy2 + 99) / 100);
  set @days = @days + ((@gy2 + 399) / 400) + @gd + @gdm;
  set @jy = -1595 + (33 * (@days / 12053));
  set @days = @days % 12053;
  set @jy = @jy + (4 * (@days / 1461));
  set @days = @days % 1461;
  If (@days > 365)
  BEGIN
    set @jy = @jy + ((@days - 1) / 365);
    set @days = (@days - 1) % 365;
  END  
  If (@days < 186 )
  begin
    set @jm = 1 + (@days / 31);
    set @jd = 1 + (@days % 31); 
	END
  ELSE
   BEGIN   
     set @jm = 7 + ((@days - 186) / 30);
     set @jd = 1 + ((@days - 186) % 30);
   END;
  Return  concat(right(concat('0',@jy),4),'/',right(concat('0',@jm),2),'/',right(concat('0',@jd),2));
End
