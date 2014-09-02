/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2004 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: fckconfig.js
 * 	Editor configuration settings.
 * 	See the documentation for more info.
 * 
 * Version:  2.0 FC (Preview)
 * Modified: 2005-03-13 17:47:07
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
 */

FCKConfig.CustomConfigurationsPath = '' ;

FCKConfig.EditorAreaCSS = FCKConfig.BasePath + 'css/fck_editorarea.css' ;

FCKConfig.BaseHref = '' ;

FCKConfig.FullPage = false ;

FCKConfig.Debug = false ;

FCKConfig.SkinPath = FCKConfig.BasePath + 'skins/default/' ;

FCKConfig.PluginsPath = FCKConfig.BasePath + 'plugins/' ;

// FCKConfig.Plugins.Add( 'placeholder', 'en,it' ) ;

FCKConfig.AutoDetectLanguage	= false ;
FCKConfig.DefaultLanguage		= 'en' ;
FCKConfig.ContentLangDirection	= 'ltr' ;

FCKConfig.EnableXHTML		= true ;
FCKConfig.EnableSourceXHTML	= true ;

FCKConfig.FillEmptyBlocks	= true ;

FCKConfig.FormatSource		= true ;
FCKConfig.FormatOutput		= true ;
FCKConfig.FormatIndentator	= '    ' ;

FCKConfig.GeckoUseSPAN	= true ;
FCKConfig.StartupFocus	= false ;
FCKConfig.ForcePasteAsPlainText	= false ;
FCKConfig.ForceSimpleAmpersand	= false ;
FCKConfig.TabSpaces		= 0 ;
FCKConfig.ShowBorders	= true ;
FCKConfig.UseBROnCarriageReturn	= false ;
FCKConfig.ToolbarStartExpanded	= true ;
FCKConfig.ToolbarCanCollapse	= true ;

FCKConfig.ToolbarSets["Default"] = [
	['Source','-','NewPage','Preview'],
	['Cut','Copy','Paste','PasteText','PasteWord','-'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','-','Outdent','Indent'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Link','Unlink','Anchor'],
	['Image','Table','Rule','Smiley','SpecialChar','UniversalKey'],
	//['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],
	'/',
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor'],
	['About']
] ;

FCKConfig.ToolbarSets["Basic"] = [
	['Bold','Italic','-','OrderedList','UnorderedList','-','Link','Unlink','Smiley','-','About']
] ;

FCKConfig.ContextMenu = ['Generic','Link','Anchor','Image','Select','Textarea','Checkbox','Radio','TextField','HiddenField','ImageButton','Button','BulletedList','NumberedList','TableCell','Table','Form'] ;

FCKConfig.FontColors = '000000,993300,333300,003300,003366,000080,333399,333333,800000,FF6600,808000,808080,008080,0000FF,666699,808080,FF0000,FF9900,99CC00,339966,33CCCC,3366FF,800080,999999,FF00FF,FFCC00,FFFF00,00FF00,00FFFF,00CCFF,993366,C0C0C0,FF99CC,FFCC99,FFFF99,CCFFCC,CCFFFF,99CCFF,CC99FF,FFFFFF' ;

FCKConfig.FontNames		= 'Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana' ;
FCKConfig.FontSizes		= '1/xx-small;2/x-small;3/small;4/medium;5/large;6/x-large;7/xx-large' ;
FCKConfig.FontFormats	= 'p;div;pre;address;h1;h2;h3;h4;h5;h6' ;

FCKConfig.StylesXmlPath	= '../fckstyles.xml' ;

FCKConfig.SpellChecker			= 'ieSpell' ;	// 'ieSpell' | 'SpellerPages'
FCKConfig.IeSpellDownloadUrl	= 'http://www.iespell.com/rel/ieSpellSetup211325.exe' ;

FCKConfig.LinkDlgHideTarget		= false ;
FCKConfig.LinkDlgHideAdvanced	= false ;

FCKConfig.ImageDlgHideLink		= false ;
FCKConfig.ImageDlgHideAdvanced	= false ;

FCKConfig.LinkBrowser = true ;
FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=connectors/asp/connector.asp' ;
//FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=connectors/asp/connector.asp&ServerPath=/CustomFiles/' ;
//FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx' ;
//FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=connectors/php/connector.php' ;
FCKConfig.LinkBrowserWindowWidth	= screen.width * 0.7 ;	// 70%
FCKConfig.LinkBrowserWindowHeight	= screen.height * 0.7 ;	// 70%

FCKConfig.ImageBrowser = true ;
FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector=connectors/asp/connector.asp' ;
//FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx' ;
//FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector=connectors/php/connector.php' ;
FCKConfig.ImageBrowserWindowWidth  = screen.width * 0.7 ;	// 70% ;
FCKConfig.ImageBrowserWindowHeight = screen.height * 0.7 ;	// 70% ;

FCKConfig.SmileyPath	= FCKConfig.BasePath + 'images/smiley/fun/' ;
//FCKConfig.SmileyImages	= ['regular_smile.gif','sad_smile.gif','wink_smile.gif','teeth_smile.gif','confused_smile.gif','tounge_smile.gif','embaressed_smile.gif','omg_smile.gif','whatchutalkingabout_smile.gif','angry_smile.gif','angel_smile.gif','shades_smile.gif','devil_smile.gif','cry_smile.gif','lightbulb.gif','thumbs_down.gif','thumbs_up.gif','heart.gif','broken_heart.gif','kiss.gif','envelope.gif'] ;
FCKConfig.SmileyImages	= ['aiua.gif','ak.gif','alien.gif','alien2.gif','angry.gif','angry1.gif','apophys.gif','assjani.gif','asthanos.gif','bazuzeus.gif','beaute.gif','bigsmile.gif','blush.gif','boid.gif','bonk.gif','bored.gif','borg.gif','capo.gif','confused.gif','cool.gif','crazy.gif','cwm14.gif','demis_roussos.gif','devil.gif','devil2.gif','double0smile.gif','eek3.gif','eltaf.gif','gele.gif','halm.gif','happy.gif','icon12.gif','icon23.gif','icon26.gif',
						   'icon_angel.gif','icon_bandit.gif','icon_bravo.gif','icon_clown.gif','jesors.gif','jesors1.gif','lol3.gif','love.gif','mad.gif','megaphone.gif','mmm.gif','music.gif','notify.gif','nuts.gif','obanon.gif','ouaip.gif','pleure.gif','plugin.gif','question.gif','question2.gif','rasta2.gif','rastapop.gif','rosebud.gif','sad.gif','sad2.gif','shocked.gif','sick.gif','sick2.gif','slaap.gif','sleep.gif','smile.gif','smiley_peur.gif','sors.gif','sovxx.gif',
						   'spamafote.gif','tap67.gif','thumbdown.gif','thumbup.gif','tigi.gif','toad666.gif','tongue.gif','tuffgong.gif','urgeman.gif','vanadium.gif','wink.gif','worship.gif'] ;
FCKConfig.SmileyColumns = 8 ;
FCKConfig.SmileyWindowWidth		= 500 ;
FCKConfig.SmileyWindowHeight	= 520 ;