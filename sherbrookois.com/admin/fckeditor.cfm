<cfparam name="attributes.toolbarset" default="Basic">
<cfparam name="attributes.width" default="600">
<cfparam name="attributes.height" default="450">
<cfparam name="attributes.name" default="entrycontent">
<cfparam name="attributes.value" default="">
<cfscript>
	caller.fckEditor = createObject("component", "FCKeditor.fckeditor");
	caller.fckEditor.instanceName  = attributes.name;
	caller.fckEditor.value                 = attributes.value;
	caller.fckEditor.toolbarSet		= attributes.toolbarset;
	caller.fckEditor.basePath              = "FCKeditor/";
	caller.fckEditor.width                 = attributes.width;
	caller.fckEditor.height                = attributes.height;
	caller.fckEditor.EditorAreaCSS = "/Inc/main.css";
	caller.fckEditor.config.GeckoUseSPAN = false ;
	caller.fckEditor.config.LinkBrowserURL = "admin/home/cffm/cffm_fck_link.cfm";
	caller.fckEditor.config.ImageBrowserURL = "admin/home/cffm/cffm_fck_image.cfm";
	caller.fckEditor.create(); // create the editor.
</cfscript>

