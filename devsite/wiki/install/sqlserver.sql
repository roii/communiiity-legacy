/* make sure you change the table name from "pages" to add the prefix you specified in CanvasConfig.xml */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[pages]
GO

CREATE TABLE [dbo].[pages] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[path] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[body] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[datetimecreated] [datetime] NOT NULL ,
	[author] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[version] [int] NOT NULL ,
	[summary] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
	[categories] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[authrolestoview] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[authrolestoedit] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
	[filename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filesize] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filemimetype] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[imagewidth] [int] NULL ,
	[imageheight] [int] NULL,
	[wiki] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL	 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

insert into pages(id, path, body, datetimecreated, author, version, summary, categories,wiki) values('EE04D302-00F3-1F8D-A3CDC239FC957A6A', 'Main', 'Welcome to CanvasWiki. To begin editing content, simply click on the ''''''edit this page'''''' link on the right.[[Category:General]]', '2005-10-12', 'Raymond Camden', '1', 'Initial', 'General','Default')
insert into pages(id, path, body, datetimecreated, author, version, summary, categories,wiki) values('EE04D302-00F3-1F8D-A3CDC239FC957A6B', 'Special.Templates.NoContentYet', '<div class="wiki_nocontentyet"><p>This page does not exist yet. To create the content, <a href="{editlink}">Edit this Page</a>.</p></div>', '2005-10-12', 'Raymond Camden', '1', 'Initial', '','Default')
insert into pages(id, path, body, datetimecreated, author, version, summary, categories,wiki) values('EE04D302-00F3-1F8D-A3CDC239FC957A6C', 'Special.Templates.Stub', '<div class="wiki_stub"><p>This article is a stub, awaiting your knowledge. Please <a href="{editlink}">edit</a> and enhance.</p></div>', '2005-10-12', 'Raymond Camden', '1', 'Initial', '','Default')