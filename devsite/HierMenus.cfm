<cfsetting enablecfoutputonly="Yes">
<cfprocessingdirective suppresswhitespace="Yes">
<cfset src_location="#request.webroot#/heirmenus/">
<cfparam name="attributes.mode" default="Make a menu">

<cfif attributes.mode IS "init">
		
	<cfparam name="attributes.MenuWidth" default = 150>
	<cfparam name="attributes.FontFamily" default = "Arial,sans-serif">
	<cfparam name="attributes.FontSize" default = 10>
	<cfparam name="attributes.FontBold" default = true>
	<cfparam name="attributes.FontItalic" default = false>
	<cfparam name="attributes.FontColor" default = "black">
	<cfparam name="attributes.FontColorOver" default = "white">
	<cfparam name="attributes.BGColor" default = "white">
	<cfparam name="attributes.BGColorOver" default = "black">
	<cfparam name="attributes.ItemPadding" default = 3>

	<cfparam name="attributes.BorderWidth" default = 2>	
	<cfparam name="attributes.BorderColor" default = "red">	
	<cfparam name="attributes.BorderStyle" default = "solid">
	<cfparam name="attributes.SeparatorSize" default = 2>
	<cfparam name="attributes.SeparatorColor" default = "yellow">	
	
	
	<cfparam name="attributes.ImageSrc" default = "#src_location#HM_More_white_right.gif">
	<cfparam name="attributes.ImageSrcLeft" default = "#src_location#HM_More_white_left.gif">
			
	<cfparam name="attributes.ImageSrcOver" default = "#src_location#HM_More_white_right.gif">
	<cfparam name="attributes.ImageSrcLeftOver" default = "#src_location#HM_More_white_left.gif">

	<cfparam name="attributes.ImageSize" default = 5>
	<cfparam name="attributes.ImageHorizSpace" default = 5>
	<cfparam name="attributes.ImageVertSpace" default = 5>

	<cfparam name="attributes.KeepHilite" default = true> 	
	<cfparam name="attributes.ClickStart" default = false>
	<cfparam name="attributes.ClickKill" default = false>
	<cfparam name="attributes.ChildOverlap" default = 20>
	<cfparam name="attributes.ChildOffset" default = 10>
	<cfparam name="attributes.ChildPerCentOver" default = "">
	<cfparam name="attributes.TopSecondsVisible" default = .5>
	<cfparam name="attributes.ChildSecondsVisible" default = .3>
	<cfparam name="attributes.StatusDisplayBuild" default = 1>
	<cfparam name="attributes.StatusDisplayLink" default = 1>	
	<cfparam name="attributes.UponDisplay" default = "">	
	<cfparam name="attributes.UponHide" default = "">	
	
	<cfparam name="attributes.RightToLeft" default = false>		
	<cfparam name="attributes.CreateTopOnly" default = "HM_NS4 ? true : false">
	<cfparam name="attributes.ShowLinkCursor" default = true>
	<cfparam name="attributes.NSFontOver" default = true>
	
	<cfparam name="attributes.TreesFromFile" default = "">		
	
	<cfset  tempheader = '<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
	if(window.event + "" == "undefined") event = null;
	function HM_f_PopUp(){return false};
	function HM_f_PopDown(){return false};
	popUp = HM_f_PopUp;
	popDown = HM_f_PopDown;
	//-->
	</SCRIPT>
	
	<SCRIPT LANGUAGE="JavaScript1.2" TYPE="text/javascript">
	<!--
	// in-page parameters

	HM_PG_MenuWidth  = "#attributes.MenuWidth#"; 
	HM_PG_FontColor  = "#attributes.FontColor#"; 
	HM_PG_FontColorOver  = "#attributes.FontColorOver#"; 
	HM_PG_FontSize  = "#attributes.FontSize#"; 
	HM_PG_FontFamily  = "#attributes.FontFamily#"; 
	HM_PG_FontBold  = "#attributes.FontBold#"; 
	HM_PG_FontItalic  = "#attributes.FontItalic#"; 
	HM_PG_BGColor  = "#attributes.BGColor#"; 
	HM_PG_BGColorOver  = "#attributes.BGColorOver#"; 
	HM_PG_ItemPadding  = "#attributes.ItemPadding#"; 
	HM_PG_BorderWidth  = "#attributes.BorderWidth#"; 
	HM_PG_BorderColor  = "#attributes.BorderColor#"; 
	HM_PG_BorderStyle  = "#attributes.BorderStyle#"; 
	HM_PG_SeparatorSize  = "#attributes.SeparatorSize#"; 
	HM_PG_SeparatorColor  = "#attributes.SeparatorColor#"; 
	HM_PG_ImageSrc  = "#attributes.ImageSrc#"; 
	HM_PG_ImageSrcLeft  = "#attributes.ImageSrcLeft#"; 
	HM_PG_ImageSrcOver  = "#attributes.ImageSrcOver#"; 
	HM_PG_ImageSrcLeftOver  = "#attributes.ImageSrcLeftOver#"; 
	HM_PG_ImageSize  = "#attributes.ImageSize#"; 
	HM_PG_ImageHorizSpace  = "#attributes.ImageHorizSpace#"; 
	HM_PG_ImageVertSpace  = "#attributes.ImageVertSpace#"; 
	HM_PG_KeepHilite  = "#attributes.KeepHilite#"; 
	HM_PG_ClickStart  = "#attributes.ClickStart#"; 
	HM_PG_ClickKill  = "#attributes.ClickKill#"; 
	HM_PG_ChildOverlap  = "#attributes.ChildOverlap#"; 
	HM_PG_ChildOffset  = "#attributes.ChildOffset#"; 
	HM_PG_ChildPerCentOver  = "#attributes.ChildPerCentOver#"; 
	HM_PG_TopSecondsVisible  = "#attributes.TopSecondsVisible#"; 
	HM_PG_ChildSecondsVisible  = "#attributes.ChildSecondsVisible#"; 
	HM_PG_StatusDisplayBuild  = "#attributes.StatusDisplayBuild#"; 
	HM_PG_StatusDisplayLink  = "#attributes.StatusDisplayLink#";
	HM_PG_UponDisplay  = "#attributes.UponDisplay#"; 
	HM_PG_UponHide  = "#attributes.UponHide#"; 
	HM_PG_RightToLeft  = "#attributes.RightToLeft#";
	HM_PG_CreateTopOnly = "#attributes.CreateTopOnly#";
	HM_PG_ShowLinkCursor = "#attributes.ShowLinkCursor#";
	HM_PG_NSFontOver = "#attributes.NSFontOver#";
	//HM_a_TreesToBuild = ... This gets set in the "Finish" section
	
	//-->
	</SCRIPT>'>
	
	<cfhtmlhead text="#TRIM(tempheader)#">
	<cfset caller.CFHM=StructNew()>
	<cfset cfhm=caller.CFHM>
	<cfset cfhm.ClickStart = attributes.ClickStart>
	<cfset cfhm.MenuItems = arraynew(2)>
	<cfset cfhm.StartMenuNumber = 51>
	<cfset cfhm.NextMenuNumber = cfhm.StartMenuNumber>
	<cfset cfhm.TreesToBuild = attributes.TreesFromFile>

<cfelseif attributes.mode IS "make a menu">
	<cfparam name="attributes.MenuItems">
	<cfparam name="attributes.ChildMenuItems" default="">
	<cfset cfhm=caller.CFHM>	
	<cfset MenuParams="MenuWidth,MenuLeft,MenuTop,FontColor,FontColorOver,BGColor,BGColorOver,BorderColor,SeparatorColor,TopPermanent,TopHorizontal,TreeHorizontal,PositionUnder,TopMoreImages,TreeMoreImages,EvalOnShow,EvalOnHide,RightToLeft,DisplayOnClick,TopIsVariableWidth,TreeIsVariableWidth">
	<cfset menulist='[' > 
	<cfif isdefined("Attributes.#ListFirst(MenuParams)#")>
		<cfset menulist = TRIM(menulist) & '"' & evaluate("Attributes.#ListFirst(MenuParams)#") & '"'>
	</cfif>
	<cfloop index="Theparam" list="#listRest(menuparams)#">
		<cfif isdefined("Attributes.#Theparam#")>
			<cfset tempval=evaluate("Attributes.#Theparam#")>
			<cfif isBoolean(tempval)>
				<cfset menulist=menulist & "," & tempval>
			<cfelse>
				<cfset menulist=menulist & ',"'& tempval & '"'>
			</cfif>
		<cfelse>
			<cfset menulist=menulist & ',' >
		</cfif>
	</cfloop>
	<cfset menulist=menulist & ']'>
	
	<cfset TheMenuNumber=cfhm.NextMenuNumber>
	<cfloop index="menuDetail" list="#attributes.MenuItems#" delimiters=";" >
		<cfset menulist=menulist & ',["' & trim(ListFirst(menuDetail)) & '"'>
			<cfloop index="el" list="#ListRest(menuDetail)#">
				<cfset element=trim(el)>
				<cfif isBoolean(element)>
					<cfset menulist=menulist & ',' & element>
				<cfelse>
					<cfset menulist=menulist & ',"' & element & '"'>
				</cfif>
			</cfloop>
			<cfset menulist=menulist & ']'>
	</cfloop>
	
	<cfset temp=arrayappend(cfhm.MenuItems[1],TheMenuNumber)>
	<cfset temp=arrayappend(cfhm.MenuItems[2],menulist)>
	<cfset cfhm.NextMenuNumber=TheMenuNumber+1>

	<cfif len(attributes.ChildMenuItems) GT 0>
		<cfset ChildMenuNumber="">
		<cfloop index="menuDetail" list="#attributes.ChildMenuItems#" delimiters=";" >
			<cfif (Listlen(menuDetail) IS 1) and (find("_",menuDetail) GT 0)>
				<cfif len(ChildMenuNumber) GT 0>
					<cfset temp=arrayappend(cfhm.MenuItems[1],ChildMenuNumber)>
					<cfset temp=arrayappend(cfhm.MenuItems[2],menulist)>
				</cfif>
				<cfset ChildMenuNumber="#TheMenuNumber#" & trim(menuDetail)>
				<cfset menulist="[]">
			<cfelse>
				<cfset menulist=menulist & ',["' & trim(ListFirst(menuDetail)) & '"'> 
					<cfloop index= "el" list="#listrest(menuDetail)#">
						<cfset element=trim(el)>
						<cfif isBoolean(element)>
							<cfset menulist=menulist & ',' & element>
						<cfelse>
							<cfset menulist=menulist & ',"' & element & '"'>
						</cfif>
					</cfloop>
					<cfset menulist=menulist & ']'>
			</cfif>
		</cfloop>
		<cfif len(ChildMenuNumber) GT 0>
			<cfset temp=arrayappend(cfhm.MenuItems[1],ChildMenuNumber)>
			<cfset temp=arrayappend(cfhm.MenuItems[2],menulist)>
		</cfif>
	</cfif>
	
	<cfif isDefined("attributes.TopPermanent") and attributes.TopPermanent is true><cfif NOT (isDefined("attributes.MenuTop") and isDefined("attributes.MenuLeft"))><h4>CF_HierMenus Error: For TopPermanent menus you must define MenuTop and MenuLeft</h4></cfif><cfelse><cfoutput>onMouseOver="popUp('HM_Menu#TheMenuNumber#',event)" onMouseOut="popDown('HM_Menu#TheMenuNumber#')"</cfoutput></cfif>
	
<cfelseif attributes.mode IS "finish">
	<cfset cfhm=caller.CFHM>
	<cfset menucount= arraylen(cfhm.MenuItems[1])>

	<cfif menucount GT 0 or len(cfhm.TreesToBuild) GT 0>
		
		<cfloop from="#cfhm.StartMenuNumber#" to="#decrementValue(cfhm.NextMenuNumber)#" Index="Menu">
			<cfset cfhm.TreesToBuild=ListAppend(cfhm.TreesToBuild,Menu)>		
		</cfloop>
		
		
		<SCRIPT LANGUAGE="JavaScript1.2" TYPE="text/javascript">
		<!--
		<cfloop from="1" to="#menucount#" index="menu">
		<cfoutput>
		HM_Array#cfhm.MenuItems[1][menu]# = [#cfhm.MenuItems[2][menu]#];
		</cfoutput>
		</cfloop>
		
		<cfoutput>
		HM_a_TreesToBuild = [#cfhm.TreesToBuild#];
		</cfoutput>
		//-->
		</SCRIPT>
		
		<cfoutput>
			<SCRIPT LANGUAGE="JavaScript1.2" SRC="#src_location#HM_Loader.js" TYPE='text/javascript'></SCRIPT>
		</cfoutput>
		
	</cfif>

<cfelse>

	<cfoutput><h3>CF_HierMenus Error: Unknown mode '#attributes.mode#'</h3></cfoutput>

</cfif>

</cfprocessingdirective>

<cfsetting enablecfoutputonly="NO">