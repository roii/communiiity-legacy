LICENSE 
Copyright 2010-2012 Raymond Camden

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
   
If you find this application worthy, I have a Amazon wish list set up (www.amazon.com/o/registry/2TCL1D08EZEYE ). Gifts are always welcome. ;)
Install directions may be found in install.doc/pdf.

Last Updated: July 6, 2013 (2.4.3)
Fix by Don Walter for his last update. 

Last Updated: May 14 (2.4.2)
/mode/PageGateway.cfc - Steve Mahony found a bug (http://canvas.riaforge.org/index.cfm?event=page.issue&issueid=28A6A621-0968-6465-719034440E4C15DB) 
that caused pages to be incorrectly marked as orphas. 


============================================= ARCHIVE =============================================

Last Updated: January 3 (2.4.1)
/model/PageRender.cfc - Don Walter submitted a change to the WikiTerm functionality to support disabling WikiTerms if the term begins with !. So doing "RaymondCamden" would create a WikiTerm, but not "!RaymondCamden". The ! is automatically hidden.
/views/dsp.navigation.cfm - Removed link and fixed name for Josh Powell. Looks like his domain is now defunt/spam ridden.

Last Updated: January 3 (2.4)
/model/PageRender.cfc - fix for bug 47: http://canvas.riaforge.org/index.cfm?event=page.issue&issueid=0F802EFE-A0CE-00EE-F8D1A20AD32CA863, thx Paul Connell
/views/layout.main.cfm, layout.printable.cfm - remove flashpaper

Last Updated: October 21, 2010 (2.3.001)
Missing/incorrect var statement fixes:
/controller/COntroller.cfc
/model/PageRender.cfc
/mode/PageGateway.cfc

Last Updated: October 18, 2010 (2.3)
/controller/COntroller.cfc - removed a dump in an error handler
/model/PageRender.cfc - fixed a horrible bug with file uploads that included dashes. I hated that bugs. Thanks to Kevin Wesley for finding it. Also removed some commented out code.

Last Updated: September 16, 2010 (2.2)
All DB scripts updated to include longer length filemimetype columns.
/config/ModelGlue.xml - When an error occurs, run the error with no template. The template was throwing errors and hiding the real error. Also does layout right for page index
/views/dsp.navigation.cfm - For some reason the Page Index link was removed. It is added back now.
/views/dsp.pageindex.cfm - updates to show page index

Last Updated: December 9, 2009 (2.1)
Updated mysql.sql script to use longtext for body column. Existing users should just change the body column to be longtext.
Note - all users should edit their DSN to Enable CLOB.

Last Updated: July 16 (2.012)

This update improves workability with MG2/MG3.

Removed the trace() statements from Controller.cfc. They were not needed and were broken due to MG API changes for CF9 compatb.
Updated Controller.cfc for MG2 compat.

Added /config/ColdSpring.xml, the files under Beans (CanvasConfig and MimeTYpes) have moved into ColdSpring.xml
Modified /config/ModelGlue.xml for better 2.0 compat.
Modified /index.cfm for ditto.

Last Updated: May 13 (2.011)
/install/oracle.sql corrected
/model/PageGateway.cfc - Oracle fix

Last Updated: March 3, 2008 (2.009)
/controller/* - No functionality changes, just switching a bunch of types to any
/install/oracle and sqlserver files didn't specify the wiki name in their installs
/model/PageGateway.cfc - just reorg of the order of methods

Last Updated: March 3, 2008 (2.008)
/model/PageRender.cfc - bug fix to the regex used for headers
/model/PageGateway.cfm - order the pages when showing pages in one category

Last Updated: January 18, 2008 (2.007)
/model/PageRender.cfc - bug fixes in the area of categories and links

Last Updated: October 17, 2007 (2.006)
Fix in PageRender.cfc, in render_code_alternate. Bug reported by Rob Brooks Bilson.
/views/dsp.navigation.cfm - new URL for me

Last Updated: September 11, 2007 (2.005)
Case issue fixed in Factory.cfc, thanks to Mr Buzzy

Last Updated: August 7, 2007 (2.004)
Brian Meloche fixed a category bug in PageRender.cfc
I had saved a showdebugoutput statement in App.cfm - removed.
Docs updated to explain need for custom mysql driver.

Last Updated: June 7, 2007 (2.003)
Install files updated to use proper markup for bold.
/model/PageRender.cfc - Verbiage on images to mention Image tag for displaying images in the media library.
/views/dsp.googlesitemap.cfm - Fixed

Last Updated: May 8, 2007 (2.002)
Oops, fixed the sql install script for real. Promise.
Also, turn off debugging in Application.cfm
Serious bugs fixed in PageGateway.cfc in regards to multi wiki installs.

Last Updated: April 20, 2007 (2.001)
Forgot "wiki" in sql server install script.

Last Updated: April 20, 2007 (2)
Everything changed. Everything. Of important note is that the Wiki Codes are different now. An
upgrade script is NOT yet available!

Last Updated: August 23, 2006 (1.5)
/config/ModelGlue.xml - changes for subnav
/controller/Controller.cfc - support for subnav (thanks to Sam Curren)
/model/PageGateway.cfc - ditto above
/model/PageRender.cfc - new render funcs, thanks to Chad Gray
/stylesheets/blueheaven.css - CSS fixes, thanks to Scott Stroz for making the fixes and Seth Brahler for finding them 
/views/dsp.body.cfm - title now has links (Sam Curren)
/views/dsp.subpagelist.cfm - subnav (Sam Curren)
/views/layout.main.cfm - layout fixes

Last Updated: August 10, 2006 (1.4.1)
/controller/Controller.cfc - Use the render of the page and a URL for emails
/model/PageDAO.cfc - removed the methods that were commented out 
/views/layout.main.cfm - make the link home work correctly

Last Updated: August 9, 2006 (1.4)
/install/oracle.sql provided by John Keir (james.forbes.keir@ibo.org)
/instal/sqlserver.sql - fixed demo page to have right markup
/views/dsp.body.cfm - show a nice title
/views/layout.main.cfm - hide certain nav on search
/model/PageGateway.cfc - mod to auto detection of path

Last Updated: June 20, 2006 (1.3)
Added support for Add Page and Search (best to copy all files)

Last Updated: June 15, 2006 (1.2.101)
Google Sitemap support added by Lucas Sherwood

Last Updated: April 4, 2006 (1.2.100)
Bug in PageRender.cfc, error occured if link was at the beginning of the page.
I modified lastupdate.cfc in variablecomponents and added new variablecomponents. 

Last Updated: April 3, 2006 (1.2)
Added config setting, emailonchange, to send emails. Setting in ModelGlue.xml. Change to Controller.cfc.
Updated docs to mention the new setting.

Last Updated: January 22, 2006 (1.1)
Version 1.1 represents the first public release. If you are a DRK user using the most recent patch you should update your files from this zip.
