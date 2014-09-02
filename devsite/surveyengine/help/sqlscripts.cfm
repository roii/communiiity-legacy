<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Online Script Library</title>
</head>

<body>
<pre>

/****** Online SQL Scripts for Survey Engine 2.0 ******/

/****** Object:  Table dbo.forms    Script Date: 4/13/99 6:01:14 AM ******/
if exists (select * from sysobjects where id = object_id('dbo.forms') and sysstat & 0xf = 3)
	drop table dbo.forms
GO

/****** Object:  Table dbo.forms    Script Date: 4/13/99 6:01:14 AM ******/
CREATE TABLE dbo.forms (
	formid int PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
	vendorid int NOT NULL DEFAULT(0),
	itemid int NOT NULL DEFAULT(0),
	dateIn smalldatetime NOT NULL DEFAULT(GETDATE()),
	header varchar (255) NULL ,
	footer varchar (255) NULL ,
	title varchar (255) NULL ,
	url varchar (255) NULL ,
	access int NULL DEFAULT(0),
	report int NULL DEFAULT(0),
	impressions int NULL DEFAULT(0),
	responses int NULL DEFAULT(0),
	verified int NULL DEFAULT(0),
	dateverified smalldatetime NULL,
	online tinyint NULL DEFAULT(0),
	dateonline smalldatetime NULL ,
	verifiedby int NULL DEFAULT(0),
	library int NULL DEFAULT(0)
)
GO

/****** Object:  Table dbo.responses    Script Date: 4/13/99 6:02:11 AM ******/
if exists (select * from sysobjects where id = object_id('dbo.responses') and sysstat & 0xf = 3)
	drop table dbo.responses
GO

/****** Object:  Table dbo.responses    Script Date: 4/13/99 6:02:11 AM ******/
CREATE TABLE dbo.responses (
	id int PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
	itemid int NOT NULL ,
	dateIn smalldatetime NOT NULL ,
	formid int NOT NULL ,
	questionid int NOT NULL ,
	vendorid int NULL ,
	respondentid int NULL ,
	option1 int NULL ,
	option2 int NULL ,
	option3 int NULL ,
	option4 int NULL ,
	option5 int NULL ,
	option6 int NULL ,
	option7 int NULL ,
	option8 int NULL ,
	option9 int NULL ,
	option10 int NULL ,
	openquestion text NULL ,
	ip varchar (20) NULL ,
	browser varchar (255) NULL 
)
GO

/****** Object:  Table dbo.questions    Script Date: 6/2/99 9:30:39 PM ******/
if exists (select * from sysobjects where id = object_id('dbo.questions') and sysstat & 0xf = 3)
	drop table dbo.questions
GO

/****** Object:  Table dbo.questions    Script Date: 6/2/99 9:30:39 PM ******/
CREATE TABLE dbo.questions (
	id int PRIMARY KEY IDENTITY (1, 1) NOT NULL ,
	itemid int NOT NULL DEFAULT(0),
	dateIn datetime NOT NULL DEFAULT(GETDATE()),
	formid int NOT NULL DEFAULT(0),
	vendorid int NULL DEFAULT(0),
	questiontype int NULL DEFAULT(0),
	question varchar (255) NULL ,
	option1 varchar (150) NULL ,
	option2 varchar (150) NULL ,
	option3 varchar (150) NULL ,
	option4 varchar (150) NULL ,
	option5 varchar (150) NULL ,
	option6 varchar (150) NULL ,
	option7 varchar (150) NULL ,
	option8 varchar (150) NULL ,
	option9 varchar (150) NULL ,
	option10 varchar (150) NULL ,
	validation int NULL DEFAULT(0)
)
GO







</pre>




</body>
</html>
