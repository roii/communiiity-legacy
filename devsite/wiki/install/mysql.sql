/* make sure you change the table name from "pages" to add the prefix you specified in CanvasConfig.xml */

DROP TABLE IF EXISTS `pages`;
CREATE TABLE  `pages` (
  `id` varchar(35) character set latin1 collate latin1_general_ci NOT NULL default '',
  `path` varchar(255) NOT NULL default '',
  `body` longtext NOT NULL,
  `datetimecreated` datetime default '0000-00-00 00:00:00',
  `author` varchar(255) default NULL,
  `version` int(11) NOT NULL default '0',
  `summary` varchar(255) default NULL,
  `categories` varchar(255) default NULL,
  `authrolestoview` varchar(255) default NULL,
  `authrolestoedit` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `filesize` varchar(255) default NULL,
  `filemimetype` varchar(255) default NULL,
  `imagewidth` int(10) unsigned default NULL,
  `imageheight` int(10) unsigned default NULL,
  `wiki` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into pages(id, path, body, datetimecreated, author, version, summary, categories, wiki) values('EE04D302-00F3-1F8D-A3CDC239FC957A6A', 'Main', 'Welcome to CanvasWiki. To begin editing content, simply click on the ''''''edit this page'''''' link on the right.[[Category:General]]', '2005-10-12', 'Raymond Camden', '1', 'Initial', 'General','Default');
insert into pages(id, path, body, datetimecreated, author, version, summary, categories, wiki) values('EE04D302-00F3-1F8D-A3CDC239FC957A6B', 'Special.Templates.NoContentYet', '<div class="wiki_nocontentyet"><p>This page does not exist yet. To create the content, <a href="{editlink}">Edit this Page</a>.</p></div>', '2005-10-12', 'Raymond Camden', '1', 'Initial', '','Default');
insert into pages(id, path, body, datetimecreated, author, version, summary, categories, wiki) values('EE04D302-00F3-1F8D-A3CDC239FC957A6C', 'Special.Templates.Stub', '<div class="wiki_stub"><p>This article is a stub, awaiting your knowledge. Please <a href="{editlink}">edit</a> and enhance.</p></div>', '2005-10-12', 'Raymond Camden', '1', 'Initial', '','Default');

