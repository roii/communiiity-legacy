

<script language="javascript">

	 
	function validateSelRate(frm){
	
		if(frm.login.value == 0){
			alert('You must be a member and need to login to vote.');
			return false;
		}
		
		
		var voteIsSelected = false;
		//loop thru check if user select  to vote
		for(i=2; i <= frm.NumOfSuggestion.value; i++){			
			var selectValue = eval('frm.rate' + i + '.value');	
			if(selectValue != 0){
				voteIsSelected = true;
				break;		
			}
		}
		
		//check if at least a vote is selected before submit
		if(!voteIsSelected){
			alert('Please select your vote before clicking vote now.');
			return false;
		}
		return true;
	}

function toggle(target,target1)
{ 
  obj=(document.all) ? document.all[target] : document.getElementById(target);
  obj1=(document.all) ? document.all[target1] : document.getElementById(target1);

  if(obj.style.display != 'none') {
     obj.style.display= 'none'; 
     obj1.style.display= 'inline';
  }
  else {
    obj.style.display='inline'; 
    obj1.style.display='none';
  }

}
	
</script>

<cfoutput>


<cfinclude template="qry_votingSug.cfm">
<cfset activityid = 2>

<table width="100%" border="0">
<tr>
<td valign="top"><a name="IdeaPond"><img height="70" src="http://www.mykidsbiz.com/images/ACF1A9.gif" width="200" align="left" border="0"></a></td>
<td valign="top">myKidsBiz is always fishing around for great ideas to make our site better. Then, as a community, we choose the best ideas. This is where you can vote on ideas/suggestions others have come up with.<br><br>

<cfif session.UserIsAuthenticated EQ 'Yes'>

	<cfquery name="UserVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM SugVote
	WHERE contactID=#session.UserID#
	</cfquery>

	To <STRONG>add your ideas &amp; suggestions</STRONG> - <cfif UserVotes.RecordCount GT 2>click <A title="to made a suggestion" href="http://www.mykidsbiz.com/index.cfm?fuseaction=sitetools&fusesubaction=article&documentid=31&articleID=22&this_query_string=#URLEncodedFormat(this_path)#">here</A><cfelse>you must vote on at least 3 other ideas first.</cfif>.&nbsp;<br><br>
For every idea or suggestion that you submit&nbsp;that gets approved and posted on the site, you will get 5 entries into the draw to win great prizes.&nbsp;And because we want your feedback,&nbsp;every suggestion you&nbsp;vote on also gets you an entry into the prize draw.&nbsp;

<cfelse>

	To <STRONG>add your ideas &amp; suggestions</STRONG> - Login first<br><br>
For every idea or suggestion that you submit&nbsp;that gets approved and posted on the site, you will get 5 entries into the draw to win great prizes.&nbsp;And because we want your feedback,&nbsp;every suggestion you&nbsp;vote on also gets you an entry into the prize draw.&nbsp;

</cfif><br><br>

<strong>NOTE:</strong> If you see any objectionable material in the IdeaPond please <a href="#request.webroot#/sitetools/dsp_report_profanity.cfm?this_query_string=#URLEncodedFormat(this_path)#" target="report" onclick="fdbackwindow=window.open ('','report','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=350,top=10,left=10')" style="color:red; text-decoration:underline;"><strong>report it to us for a reward</strong></a>.

</td>
</tr>

</table>

<cfinclude template="../administration/dsp_prize.cfm">

<table width="100%" cellspacing="1" cellspacing="1">

<tr>
	<td>
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
		<tr bgcolor="004080" height="35" class="normal">
			<td style="color:white;" align="center">The suggestions/ideas</td>
			<td style="color:white;" align="center">By</td>
			<td style="color:white;" align="center">Closed <br> Date</td>			
			<td style="color:white;" align="center">Vote <br> Received</td>
			<td style="color:white;" align="center">Avg <br> Vote</td>
			<td style="color:white;" align="center">What is<br>your vote?</td>			
		</tr>
		
		
		<!--- display base on user not authenticate --->
		<form name="frmSuggestion" action="#request.webroot#/sitetools/act_voteSug.cfm" method="post" onSubmit="return validateSelRate(this)">
		<!--- user is not authenticate value = 0 --->
		<input type="hidden" name="login" <cfif session.UserIsAuthenticated EQ 'yes'> value="1" <cfelse> value="0"</cfif> >
		<!--- number of suggestion display for voting --->
		<input type="hidden" name="NumOfSuggestion" value="#Suggestion.recordCount#">
		
		<!--- checkbox identify --->
		<cfset selectBoxCount = 0>
						
		<cfloop query="Category">
		
		
		
		
			<!--- select suggestion only belong to this current category --->
			
			
			<!--- if this user has voted more than 3 times show pending as well as active --->
			<cfif IsDefined("UserVotes") AND UserVotes.RecordCount GT 2>
			
				<cfquery dbtype="query" name="CatSug">		
				SELECT *
				FROM Suggestion
				WHERE categoryID = #categoryID#
				AND Path = '#TRIM(this_path)#'
				AND Archived=0
				</cfquery>
			
			<cfelse>
			
				<cfquery dbtype="query" name="CatSug">		
				SELECT *
				FROM Suggestion
				WHERE categoryID = #categoryID#
				AND Path = '#TRIM(this_path)#'
				AND Authorise = 'yes'
				AND Archived=0
				</cfquery>
			
			</cfif>
			
			<!--- on display where category has suggestions --->
			<cfif CatSug.recordCount GT 0>
			
			<!--- display the category Name --->
			<tr class="normal">
				<td colspan="6" bgcolor="e3f4f6" height="12"><b>#TRIM(Name)#</b></td> 
			</tr>
			
			<!--- loop to display the suggestion --->
			<cfloop query="CatSug">
				
				<cfset selectBoxCount = selectBoxCount  + 1>
				
				<!--- set the background color of the row --->				
				<cfset bgColor = "FFFFFF">
				<cfset vote = 0 >
				
				<cfif session.UserIsAuthenticated EQ 'yes'>
					<!--- check if user has been vote for this current suggestion --->
					<cfquery dbtype="query"  name="isUserVote">
						select 	*
						from 	UserVotedSuggestion	
						where	sugID = #sugID#	
					</cfquery>
				
					<!--- user has vote if isUserVote recordCount > 0 or the suggestion was made by the user --->
					<cfif isUserVote.recordCount OR (contactID NEQ '' AND contactID EQ session.UserID)>
					
						<cfset bgColor="a0d8e0">
						<cfset vote = 1>
						
					</cfif> 
				</cfif>
			
			
			<tr class="normal" bgcolor="#bgColor#">
							
				<!--- suggestion --->
				<td>
					<cfif len(suggestion) GT 50>
						<div id="d1#sugID#">
						#mid(suggestion,1,50)# 
						<a title="show" href="javascript: void(0);" onClick="toggle('d2#sugID#', 'd1#sugID#');">more..</a>
						</div>
						<div id="d2#sugID#">
						#suggestion#
						<a title="hide" href="javascript: void(0);" onClick="toggle('d1#sugID#', 'd2#sugID#');">collapse</a>
						</div>
						<script language="javascript">toggle('d2#sugID#', 'd1#sugID#');</script>
					<cfelse>
						#suggestion#
					</cfif>
				</td>
				
				<!--- suggestion made by --->
				<td align="center">#madeBy#</td>
				
				<!--- close date of suggestion --->
				<td align="center">#whenVotingClose#</td>
				
				<!--- vote Received only display when user voted the suggestion--->		
				<td align="center"><cfif vote EQ 1>#voteReceived#</cfif></td>
				<!---Avg vote only display when user voted the suggestion--->				
				<td align="center"><cfif vote EQ 1>#avgVote#</cfif></td>
				
				<!--- display user vote option --->
				<td align="center">
					<select name="rate#selectBoxCount#" class="normal" <cfif vote EQ 1>disabled</cfif>>
						<option value="0">Select</option>
						<option value="1">It stinks</option>
						<option value="2">Not so good</option>
						<option value="3">It's OK</option>
						<option value="4">It's good</option>
						<option value="5">It's a winner!</option>
					</select>
				</td>
			
				<!--- hidden sugid value for each row --->
				<input type="hidden" name="sugID#selectBoxCount#" value="#sugID#">			
			</tr>					
				
			</cfloop>
			<tr>
			<td colspan="6"><hr width="100%" size="1" color="e2e2e2"></td>
			</tr>			
			</cfif>
		
		</cfloop>
		<tr>
		<td colspan="6" align="center"><input  type="submit" name="subVote" value="Vote Now!"></td>
		</tr>		
		
		<tr>
		<td colspan="6"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>			
			
		</form>
		
		</table>

</td>
</tr>


<tr class="normal">
<td>

<cfif session.UserIsAuthenticated EQ 'Yes'>

	To <STRONG>add your ideas &amp; suggestions</STRONG> - <cfif UserVotes.RecordCount GT 2>click <A title="to made a suggestion" href="http://www.mykidsbiz.com/index.cfm?fuseaction=sitetools&fusesubaction=article&documentid=31&articleID=22&this_query_string=#URLEncodedFormat(this_path)#">here</A><cfelse>you must vote on at least 3 other ideas first.</cfif>.&nbsp;<br><br>
For every idea or suggestion that you submit&nbsp;that gets approved and posted on the site, you will get 5 entries into the draw to win great prizes.&nbsp;And because we want your feedback,&nbsp;every suggestion you&nbsp;vote on also gets you an entry into the prize draw.&nbsp;

<cfelse>

	To <STRONG>add your ideas &amp; suggestions</STRONG> - Login first<br><br>
For every idea or suggestion that you submit&nbsp;that gets approved and posted on the site, you will get 5 entries into the draw to win great prizes.&nbsp;And because we want your feedback,&nbsp;every suggestion you&nbsp;vote on also gets you an entry into the prize draw.&nbsp;

</cfif>

</td>
</tr>


</table>
		
</cfoutput>
		