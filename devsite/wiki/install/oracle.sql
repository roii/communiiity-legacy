/* make sure you change the table name from "pages" to add the prefix you specified in CanvasConfig.xml */

DROP TABLE PAGES CASCADE CONSTRAINTS;

CREATE TABLE PAGES
(
ID  VARCHAR2(35 CHAR) NOT NULL,
PATH VARCHAR2(255 CHAR)           NOT NULL,
BODY             CLOB NOT NULL,
DATETIMECREATED  DATE NOT NULL,
AUTHOR VARCHAR2(255 CHAR),
VERSION NUMBER(6) NOT NULL,
SUMMARY          VARCHAR2(255 CHAR),
CATEGORIES       VARCHAR2(255 CHAR),
AUTHROLESTOVIEW  VARCHAR2(255 CHAR),
AUTHROLESTOEDIT  VARCHAR2(255 CHAR),
FILENAME         VARCHAR2(255 CHAR),
FILESIZE         VARCHAR2(255 CHAR),
FILEMIMETYPE     VARCHAR2(255 CHAR),
IMAGEWIDTH       NUMBER(6),
IMAGEHEIGHT      NUMBER(6),
WIKI VARCHAR2(255 CHAR)
);

INSERT INTO PAGES ( ID, PATH, BODY, DATETIMECREATED, AUTHOR, VERSION, SUMMARY, CATEGORIES, WIKI ) VALUES ( 
'EE04D302-00F3-1F8D-A3CDC239FC957A6E', 'Main', 'Welcome to CanvasWiki. To begin editing content, simply click on the ''''''edit this page'''''' link on the right.'
,  TO_Date( '12/10/2005 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 'Raymond Camden'
, 1, 'Initial', 'General','Default'); 

INSERT INTO PAGES ( ID, PATH, BODY, DATETIMECREATED, AUTHOR, VERSION, SUMMARY, CATEGORIES, WIKI ) VALUES ( 
'EE04D302-00F3-1F8D-A3CDC239FC957A6B', 'Special.Templates.NoContentYet', '<div class="wiki_nocontentyet"><p>This page does not exist yet. To create the content, <a href="{editlink}">Edit this Page</a>.</p></div>', TO_Date( '12/10/2005 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 'Raymond Camden', '1', 'Initial', '','Default');

INSERT INTO PAGES ( ID, PATH, BODY, DATETIMECREATED, AUTHOR, VERSION, SUMMARY, CATEGORIES, WIKI ) VALUES ( 
'EE04D302-00F3-1F8D-A3CDC239FC957A6C', 'Special.Templates.Stub', '<div class="wiki_stub"><p>This article is a stub, awaiting your knowledge. Please <a href="{editlink}">edit</a> and enhance.</p></div>', TO_Date( '12/10/2005 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 'Raymond Camden', '1', 'Initial', '', 'Default');