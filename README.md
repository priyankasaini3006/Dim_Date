# Dim_Date
Date dimension created in SQL Server. It is useful for reporting purposes. 
COLUMN NAME	DATA TYPE	ALLOW NULLS?	DESCRIPTION
[DateKey] 	INT		The primary key
[Date]	DATE		Date
[Day] 	TINYINT		Day in number (1 to 31)
[DaySuffix]	CHAR(2)		Suffix of the day (st,nd,th)
[Weekday] 	TINYINT		Weekday in number 
1= Sunday 
2=Monday
3= Tuesday
4= Wednesday
5= Thursday
6= Friday
7 = Saturday
[WeekDayName]	VARCHAR(10)		Name of the weekday (Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday)
[WeekDayName_Short] 	CHAR(3)		(First 3 letters) Abbreviated name of the weekday (SUN, MON, TUE, WED, THU, FRI, SAT)
[DayOfYear]	SMALLINT		The day number of the year (1 to 365 or 366)
[WeekOfMonth] 	TINYINT		The week number of the month (1 to 6)
[WeekOfYear]	TINYINT		The week number of the year (1 to 52 or 53)
[YYYYWeekofYear] char(6) It is a concatenation of YYYY+week of the year. For eg, year is 2019 and week is 40 [YYYYWeekofYear]=201940
[Month]	TINYINT		Month in number 
1= January
2= February
3= March
4= April
5= May
6= June
7=July
8= August
9= September
10= October
11= November
12= December
[MonthName]	VARCHAR(10)		Complete Month Name (January to December)
[MonthName_Short]	CHAR(3)		(First 3 letter) Abbreviated Month Name (JAN-DEC)
[Quarter]	TINYINT		Four Quarter in number
1= First Quarter
2= Second Quarter
3= Third Quarter
4= Fourth Quarter
[QuarterName] 	VARCHAR(6)		Name of the Quarter(First, Second, Third, Fourth)
[Year]	INT		Year in YYYY Format 
[MMYYYY]	CHAR(6)		Month and Year in MMYYYY format
Eg: 012020 
[MonthYear]	CHAR(7)		Month and Year in MMMYYYY format
Eg: JAN2020
IsWeekend	BIT		If it is a weekend or not?
0= weekday
1= weekend
IsHoliday	BIT		If it is a holiday or not?
1= Holiday
2= No Holiday
HolidayName 	VARCHAR(100)		Name of the important US Holidays:
New Year’s Day (1st January)
Martin Luther King’s Day(3rd Monday of January)
President’s Day(3 Monday of February)
Memorial Day(Final Monday of May)
Independence Day (July 4th)
Labor Day: (First Monday of September)
Columbus Day(Second Monday of October)
Veterans Day (November 11th)
Thanksgiving (Final Thursday of November)
Christmas (December 25th)
[FiscalYear]	INT	YES	Same as calendar year
[FiscalQuater] 	INT	YES	Same as calendar year
[FiscalMonth]	TINYINT	YES	Same as calendar year
[FiscalWeek]	TINYINT	YES	Fiscal week number of a month from 1 to 5 (starting from Sunday to Saturday). 
FirstDateofYear]	DATE	YES	First day of the year. Eg: if it is year 2020, then it is 2020-01-02
[LastDateofYear]	DATE	YES	Last day of the year. Eg: if it is year 2020, then it is 2020-12-31
[FirstDateofQuater]	DATE	YES	First day of the quarter. Eg: if it is year 2020-05-10, then it is 2020-04-01
[LastDateofQuater]	DATE	YES	Last day of the quarter. Eg: if it is year 2020-05-10, then it is 2020-06-30
[FirstDateofMonth] 	DATE	YES	First day of the month. Eg: if it is year 2020-05-10, then it is 2020-05-01
[LastDateofMonth]	DATE	YES	Last day of the month. Eg: if it is year 2020-05-10, then it is 2020-05-31
[FirstDateofWeek]	DATE	YES	First day of the week. Eg: if it is year 2020-05-10, then it is 2020-05-10
[LastDateofWeek]	DATE	YES	Last day of the week. Eg: if it is year 2020-05-10, then it is 2020-05-16
