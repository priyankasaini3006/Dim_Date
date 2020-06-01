use Database_Name
go


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON

--drop table Dim_Date
TRUNCATE TABLE Dim_Date

CREATE TABLE [dbo].[Dim_Date] (
   [DateKey] [int] NOT NULL,
   [Date] [date] NOT NULL,
   [Day] [tinyint] NOT NULL,
   [DaySuffix] [char](2) NOT NULL,
   [Weekday] [tinyint] NOT NULL,
   [WeekDayName] [varchar](10) NOT NULL,
   [WeekDayName_Short] [char](3) NOT NULL,
   [DayOfYear] [smallint] NOT NULL,
   [WeekOfMonth] [tinyint] NOT NULL,
   [WeekOfYear] [tinyint] NOT NULL,
   [YYYYWeekofYear] [char](6) NOT NULL,
   [Month] [tinyint] NOT NULL,
   [MonthName] [varchar](10) NOT NULL,
   [MonthName_Short] [char](3) NOT NULL,
   [Quarter] [tinyint] NOT NULL,
   [QuarterName] [varchar](6) NOT NULL,
   [Year] [int] NOT NULL,
   [MMYYYY] [char](6) NOT NULL,
   [MonthYear] [char](7) NOT NULL,
   IsWeekend BIT NOT NULL,
   IsHoliday BIT NOT NULL,
   HolidayName VARCHAR(100) NULL,
   [FiscalYear] [int] NULL,
   [FiscalQuarter] [int] NULL,
   [FiscalMonth] [int] NULL,
   [FiscalWeek] [tinyint] null,
   [FirstDateofYear] DATE NULL,
   [LastDateofYear] DATE NULL,
   [FirstDateofQuarter] DATE NULL,
   [LastDateofQuarter] DATE NULL,
   [FirstDateofMonth] DATE NULL,
   [LastDateofMonth] DATE NULL,
   [FirstDateofWeek] DATE NULL,
   [LastDateofWeek] DATE NULL,
--   CurrentYear SMALLINT NULL,
--   CurrentQuater SMALLINT NULL,
--   CurrentMonth SMALLINT NULL,
--   CurrentWeek SMALLINT NULL,
--   CurrentDay SMALLINT NULL,
   PRIMARY KEY CLUSTERED ([DateKey] ASC)
   )

DECLARE @CurrentDate DATE = '2017-12-31'
DECLARE @EndDate DATE = '2025-12-31'

WHILE @CurrentDate < @EndDate
BEGIN
   INSERT INTO [dbo].[Dim_Date] (
      [DateKey],
      [Date],
      [Day],
      [DaySuffix],
      [Weekday],
      [WeekDayName],
      [WeekDayName_Short],
      [DayOfYear],
      [WeekOfMonth],
	  [WeekOfYear],
	  [YYYYWeekofYear],
      [Month],
      [MonthName],
      [MonthName_Short],
      [Quarter],
      [QuarterName],
      [Year],
      [MMYYYY],
      [MonthYear],
      [IsWeekend],
      [IsHoliday],
      [FirstDateofYear],
      [LastDateofYear],
      [FirstDateofQuarter],
      [LastDateofQuarter],
      [FirstDateofMonth],
      [LastDateofMonth],
      [FirstDateofWeek],
      [LastDateofWeek],
	  [FiscalWeek]
	  )
   SELECT DateKey = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate),
      DATE = @CurrentDate,
      Day = DAY(@CurrentDate),
      [DaySuffix] = CASE 
         WHEN DAY(@CurrentDate) = 1
            OR DAY(@CurrentDate) = 21
            OR DAY(@CurrentDate) = 31
            THEN 'st'
         WHEN DAY(@CurrentDate) = 2
            OR DAY(@CurrentDate) = 22
            THEN 'nd'
         WHEN DAY(@CurrentDate) = 3
            OR DAY(@CurrentDate) = 23
            THEN 'rd'
         ELSE 'th'
         END,
      WEEKDAY = DATEPART(dw, @CurrentDate),
      WeekDayName = DATENAME(dw, @CurrentDate),
      WeekDayName_Short = UPPER(LEFT(DATENAME(dw, @CurrentDate), 3)),
      [DayOfYear] = DATENAME(dy, @CurrentDate),
      [WeekOfMonth] =  DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1,
	  [WeekOfYear] = DATEPART(wk, @CurrentDate),
	  [YYYYWeekofYear]= CAST(year as varchar(4)) + CAST(WeekOfYear AS VARCHAR(2))  
      [Month] = MONTH(@CurrentDate),
      [MonthName] = DATENAME(mm, @CurrentDate),
      [MonthName_Short] = UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [Quarter] = DATEPART(q, @CurrentDate),
      [QuarterName] = CASE 
         WHEN DATENAME(qq, @CurrentDate) = 1
            THEN 'First'
         WHEN DATENAME(qq, @CurrentDate) = 2
            THEN 'Second'
         WHEN DATENAME(qq, @CurrentDate) = 3
            THEN 'Third'
         WHEN DATENAME(qq, @CurrentDate) = 4
            THEN 'Fourth'
         END,
      [Year] = YEAR(@CurrentDate),
      [MMYYYY] = RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)),
      [MonthYear] =  UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)),
      [IsWeekend] = CASE 
         WHEN DATENAME(dw, @CurrentDate) = 'Sunday'
            OR DATENAME(dw, @CurrentDate) = 'Saturday'
            THEN 1
         ELSE 0
         END,
      [IsHoliday] = 0,
      [FirstDateofYear] = CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-01-01' AS DATE),
      [LastDateofYear] = CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-12-31' AS DATE),
      [FirstDateofQuarter]= case when DATEPART(q, @CurrentDate) = 1 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-01-01' AS DATE)
								when DATEPART(q, @CurrentDate) = 2 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-04-01' AS DATE)
								when DATEPART(q, @CurrentDate) = 3 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-07-01' AS DATE)
								when DATEPART(q, @CurrentDate) = 4 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-10-01' AS DATE)
								else null end,
      [LastDateofQuarter] = case when DATEPART(q, @CurrentDate) = 1 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-03-31' AS DATE)
								when DATEPART(q, @CurrentDate) = 2 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-06-30' AS DATE)
								when DATEPART(q, @CurrentDate) = 3 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-09-30' AS DATE)
								when DATEPART(q, @CurrentDate) = 4 then  CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-12-31' AS DATE)
								else null end,
      [FirstDateofMonth] = CAST(CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + '-' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)) + '-01' AS DATE),
      [LastDateofMonth] = EOMONTH(@CurrentDate),
      [FirstDateofWeek] = DATEADD(dd, - (DATEPART(dw, @CurrentDate) - 1), @CurrentDate),
      [LastDateofWeek] = DATEADD(dd, 7 - (DATEPART(dw, @CurrentDate)), @CurrentDate),
	  [FiscalWeek]=  case when DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1 = 1 then 1
							when DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1 = 2 then 2
							when DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1 = 3 then 3
							when DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1  = 4 then 4
							when DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1 = 5 then 5
							when DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1 = 6 then 1
							else null end
   SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Update U.S. Holiday information


/* New Year’s Day (1st January)..
Martin Luther King’s Day (3rd Monday of January)
President’s Day (3 Monday of February)
Memorial Day (Final Monday of May)
Independence Day: (July 4th)..
Labor Day: (First Monday of September)
Columbus Day: (Second Monday of October)
Veterans Day: (November 11th)..
Thanksgiving: (Final Thursday of November)
Christmas: (December 25th) ..
*/


/**** U.S. Holidays with fixed dates****/
--New Year’s Day (1st January)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName] = 'New Year''s Day'
WHERE [Month] = 1
AND [DAY] = 1

--Independence Day: (July 4th)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName] = 'Independence Day'
WHERE [Month] = 7
AND [DAY] = 4

--Veterans Day: (November 11th)..
UPDATE Dim_Date
SET [IsHoliday]= 1,
[HolidayName]= 'Veterans Day'
where [Month] = 11
AND [Day]= 11

--Christmas: (December 25th)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName] = 'Christmas'
WHERE [Month] = 12
AND [DAY] = 25

/**** U.S. Holidays with varying dates*****/

--Martin Luther King’s Day (3rd Monday of January)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName]= 'Martin Luther King''s Day'
where Date = DATEADD(WEEK, 2, DATEADD(d, Case when DATEPART(dw, FirstDateofMonth)>2 Then 7 Else 0 ENd + (2 - DATEPART(dw, FirstDateofMonth)), FirstDateofMonth))
and [Month]=1

--President’s Day (3rd Monday of February)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName]= 'President''s Day'
where Date = DATEADD(WEEK, 2, DATEADD(d, Case when DATEPART(dw, FirstDateofMonth)>2 Then 7 Else 0 ENd + (2 - DATEPART(dw, FirstDateofMonth)), FirstDateofMonth))
and [Month]=2


--Memorial Day (Final Monday of May)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName]= 'Memorial Day'
where Date =  dateadd(week,-1,DATEADD(Week,datediff (Week,0,dateadd (day,6-datepart (Day, dateadd(mm,1, FirstDateofMonth)),dateadd(mm,1,FirstDateofMonth))), 0))
and [Month]=5


--Labor Day: (First Monday of September)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName]= 'Labor Day'
where Date = DATEADD(Week,datediff (Week,0,dateadd (day,6-datepart (Day, FirstDateofMonth),FirstDateofMonth)), 0)
and [Month]=9

--Columbus Day: (Second Monday of October)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName]= 'Columbus Day'
where Date= DATEADD (Week,datediff (Week,0,dateadd (day,6-datepart (Day, FirstDateofMonth), FirstDateofMonth)), 7)
and [Month]=10

--Thanksgiving: (Final Thursday of November)
UPDATE Dim_Date
SET [IsHoliday] = 1,
[HolidayName]= 'Thanksgiving Day'
where Date = DATEADD(WEEK, 3, DateAdd(day, (7+5 -DatePart(weekday, FirstDateofMonth))%7, FirstDateofMonth) )
and [Month] = 11

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Update Fiscal Year, Quarter and Month information

UPDATE Dim_Date
SET  [FiscalYear] = Year,
	  [FiscalQuarter]= Quarter,
	  [FiscalMonth]= Month

--Update Fiscal Week (Sunday to Saturday)
UPDATE Dim_Date
SET Fiscalweek = 1 
where month(Date) != month(LastDateofWeek) 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------





