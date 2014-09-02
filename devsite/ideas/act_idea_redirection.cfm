<!--- GET THE DIFFERENT IDEA COUNTS (Active, Need My Vote, Returned, Winner) --->
<cfset this_categoryID = currentcategory>
<cfinclude template="qry_topic_ideas_count.cfm">


<cfif form.IdeaMode EQ 'Active'>
	<cflocation url= "#request.webroot#/index.cfm?fuseaction=#form.fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#form.currentcategory#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No&IdeaMode=Active">

<cfelseif form.IdeaMode EQ 'NeedMyVote'>
	<cflocation url= "#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#form.currentcategory#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=Yes&IdeaMode=NeedMyVote">

<cfelseif form.IdeaMode EQ 'Returned'>
	<cflocation url= "#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#form.currentcategory#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ReturnedIdeas.SugID)#&IdeaFunL_hideIdeas=No&IdeaMode=Returned">

<cfelseif form.IdeaMode EQ 'Winner'>
	<cflocation url= "#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=78&currentcategory=#form.currentcategory#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_WinnerIdeas.SugID)#&IdeaMode=Winner">


<cfelse>
	<cflocation url= "#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=78&currentcategory=#form.currentcategory#&IdeaFunL_StartRow=1&IdeaMode=All">

</cfif>