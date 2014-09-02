

<cfquery name="edbann" datasource="#dsn#" username="#db_user#" password="#db_password#" >
	select * from banner where id=#URL.ID#</cfquery>
	
<cfset pos = #edbann.position# />
<cfset stts = #edbann.status# />
<cfset vis = #edbann.shownto# />

<cfscript>

	t=0;
	r=0;
	l=0;
	
	act=0;
	dact=0;
	
	li=0;
	lo=0;
	bt=0;
	
	t=Compare(pos, "top");
	r=Compare(pos, "right");
	l=Compare(pos, "left");
	
	act=Compare(stts, "active");
	dact=Compare(stts, "inactive");
	
	li=Compare(vis, "login");
	lo=Compare(vis, "logout");
	bt=Compare(vis, "both");
	
</cfscript>

<form action="saveeditbann.cfm" method="post" enctype="multipart/form-data">

<cfoutput><label>Banner file name: </label><label>#edbann.file_name#</label><br /><br />
	Existing banner: <img src="#request.imageroot#/banner/#edbann.file_name#" width="100px" height="100px" align="middle" /><br /><br />
	To change banner upload:	<input type="file" name="bann" id="bann" /><br /><br />
	
</cfoutput>

<label>Select the Banner Position: </label>	
<cfif l EQ 1>
	<input type="radio" value="left" name="posi" id="left" checked="checked" /><label for="left">Left</label>
<cfelse>
	<input type="radio" value="left" name="posi" id="left" /><label for="left">Left</label>
</cfif>

<cfif t EQ 1>
	<input type="radio" value="top" name="posi" id="top" checked="checked" /><label for="top">Top</label>
<cfelse>
	<input type="radio" value="top" name="posi" id="top" /><label for="top">Top</label>
</cfif>

<cfif r EQ 1>
	<input type="radio" value="right" name="posi" id="right" checked="checked"  /><label for="right">Right</label>
<cfelse>
	<input type="radio" value="right" name="posi" id="right"  /><label for="right">Right</label>
</cfif>

<br /><br />
		<label>Activate/Deactivate:</label>
		
		<cfif act EQ 1>
			<input checked="checked" type="radio" value="active" name="act" id="active" /><label for="active">Activate</label>
		<cfelse>
			<input type="radio" value="active" name="act" id="active" /><label for="active">Activate</label>
		</cfif>
		<cfif dact EQ 1>
			<input checked="checked" type="radio" value="inactive" name="act" id="inactive" /><label for="inactive">Deactivate</label><br /><br />
		<cfelse>
			<input type="radio" value="inactive" name="act" id="inactive" /><label for="inactive">Deactivate</label><br /><br />
		</cfif>
		
		
		
		<label>To Whom to Show:</label>
		
		<cfif li EQ 0>
			<input checked="checked" type="radio" value="login" name="log" id="in" /><label for="in">To Logged In users</label>
		<cfelse>
			<input type="radio" value="login" name="log" id="in" /><label for="in">To Logged In users</label>
		</cfif>
		
		<cfif lo EQ 0>
			<input checked="checked" type="radio" value="logout" name="log" id="out" /><label for="out">To Logged Out users</label>
		<cfelse>
			<input type="radio" value="logout" name="log" id="out" /><label for="out">To Logged Out users</label>
		</cfif>
		
		<cfif bt EQ 0>
		<input checked="checked" type="radio" value="both" name="log" id="all" /><label for="all">To All users</label><br /><br />
		<cfelse>
				<input type="radio" value="both" name="log" id="all" /><label for="all">To All users</label><br /><br />
		</cfif>

		<input type="submit" value="Save" />
		<input type="hidden" name="id" value="<cfoutput>#edbann.id#</cfoutput>" />
	

</form>


<a href="http://localhost:8500/my3psite/index.cfm?fuseaction=administration&fusesubaction=manage_banner">Back to Banners Management</a>
