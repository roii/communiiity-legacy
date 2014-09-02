<cfquery name="mySurveys" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
	SELECT * FROM forms f,surveycom s,kids2survey ks,contacts c where f.comid = s.surveycomID 
	and f.formid = ks.formid and c.contactid = ks.kidsid and c.contactid = #session.UserID#
	and f.verified = 1 and f.nodone <> f.noneeded and ks.completed = 0 order by f.formID desc
</cfquery>

<cfquery name="myDoneSurveys" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
	SELECT * FROM forms f,surveycom s,kids2survey ks,contacts c where f.comid = s.surveycomID 
	and f.formid = ks.formid and c.contactid = ks.kidsid and c.contactid = #session.UserID#
	and f.verified = 1 and f.nodone <> f.noneeded and ks.completed = 1 order by f.formID desc
</cfquery>

<cfquery name="AllSurveys" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
	SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID and forms.verified = 1 
	and forms.noneeded > 0
	and forms.formid not in (select formid from kids2survey where kidsid = #session.userid#)
	order by forms.formID desc
</cfquery>

<cfquery name="AllSurveys" dbtype="query">
   select distinct description,price,online,formid,title,comlogo,comName,deadline,NoNeeded,NoDone from AllSurveys
</cfquery>

<br>
<cfif AllSurveys.recordcount GT 0>
<span class="heading">Surveys Available</span>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="100%">
	<tr bgColor="a0d8e0">
         <td width="15%"><b>Survey Title</b></td>
		 <td widht="25%"><b>Description</b></td>
		 <cfif AllSurveys.online eq 0>
		 <td widht="5%"><b>Pay per survey</b></td>
		 </cfif>
	 <td width="15%"><b>Company</b></td>
	 <td width="5%"><b>Deadline</b></td>
	 <td width="20%"><b>No. Completed</b></td>
	 <td width="15%"><b>Action</b></td>
       </tr>

    <cfoutput query="AllSurveys">
       <tr bgColor="e3f4f6">
         <td>#AllSurveys.title#</a></td>
		 <td>#AllSurveys.description#</td>
		 <cfif AllSurveys.online eq 0>
		 <td widht="50">#dollarformat(AllSurveys.price)#</td>
		 </cfif>
         <td><cfif AllSurveys.comlogo neq ''><img src="#request.webroot#/surveyengine/images/#AllSurveys.comlogo#" border=0>
	     <cfelse>#AllSurveys.comName#</cfif></td>
	 <td>#Dateformat(AllSurveys.deadline,"dd/mmm/yyyy")#</td>
	 <td>
          <cfif AllSurveys.NoNeeded neq 0>
             <cfset done=AllSurveys.NoDone/AllSurveys.NoNeeded * 100>
	  <cfelse>
            <cfset done=0>
	  </cfif>
	  <cfset todo=100-done>
	  <cfset left=AllSurveys.NoNeeded - AllSurveys.NoDone>
	  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
          <tr>
	   <td width="50%" align=left>#AllSurveys.NoDone# Done</td>
	   <td width="50%" align=right>#left# To Go</td>
	  </tr>
	  </table>
	  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
	  <tr>
	   <td style="background-color:red" width="#done#%"><cfif done GT 0>&nbsp;</cfif></td>
           <td style="background-color:green" width="#todo#%"><cfif todo GT 0>&nbsp;</cfif></td>
	  </tr>
	  </table>
	  </td>
	 <td>
          <cfif online EQ 1>
            [<a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=25&surveyid=#AllSurveys.formid#">Do Survey</a>]
          <cfelse>
            [<a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=25&surveyid=#AllSurveys.formid#" onclick="return confirm('Are you sure you want to do this survey?')">Do Survey</a>]
	  </cfif>
	</td>
       </tr>
    </cfoutput>
  </table>
  <br>
  <hr>
<cfelse> 
<h4>There are currently no active surveys</h4>
<br>
<hr>
</cfif>

<cfif mySurveys.recordcount GT 0>
<span class="header">Surveys I am doing</span>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
         <td width="15%"><b>Survey Title</b></td>
		 <td width="35%"><b>Description</b></td>
	 <td width="15%"><b>Company</b></td>
	 <td width="5%"><b>Deadline</b></td>
	 <td width="5%"><b>No. I've Completed</b></td>
	 <td width="20%"><b>Total No. Completed</b></td>
	 <td width="15%"><b>Action</b></td>
       </tr>

    <cfoutput query="mySurveys">
       <tr bgColor="e3f4f6">
         <td>#mySurveys.title#</td>
		 <td>#mySurveys.description#</td>
	 <td><cfif mySurveys.comlogo neq ''><img src="#request.webroot#/surveyengine/images/#mySurveys.comlogo#" border=0>
	     <cfelse>#mySurveys.comName#</cfif></td>
	 <td>#Dateformat(mySurveys.deadline,"dd/mmm/yyyy")#</td>
	 <td>#mySurveys.nodone#</td>
	  <cfif mySurveys.NoNeeded neq 0>
             <cfset done=mySurveys.NoDone/mySurveys.NoNeeded * 100>
	  <cfelse>
            <cfset done=0>
	  </cfif>
	  <cfset todo=100-done>
	  <cfset left=mySurveys.NoNeeded - mySurveys.NoDone>
	 <td>
	  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
          <tr>
	   <td width="50%" align=left>#mySurveys.NoDone# Done</td>
	   <td width="50%" align=right>#left# To Go</td>
	  </tr>
	  </table>
	  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
        
	  <tr>
	    <td style="background-color:red" width="#done#%"><cfif done GT 0>&nbsp;</cfif></td>
           <td style="background-color:green" width="#todo#%"><cfif todo GT 0>&nbsp;</cfif></td>
	  </tr>
	  </table>
	  </td>
	 <td>
	  [<a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=27&surveyid=#formid#">Enter Survey</a>]
	  [<a href="#request.webroot#/kidzbiz/dsp_print_survey.cfm?surveyid=#formid#" target="_blank">Print Survey</a>]
          [<a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=28&surveyid=#formid#" onclick="return confirm('Are you sure you want to finish this survey?')">Finish Survey</a>]
	</td>
       </tr>
    </cfoutput>
  </table>
<cfelse>
</cfif>
<br>

<cfif myDoneSurveys.recordcount GT 0>
<span class="header">Surveys I have done</span>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
         <td width="15%"><b>Survey Title</b></td>
		 <td widht="30%"><b>Description</b></td>
	 <td width="15%"><b>Company</b></td>
	 <td width="10%"><b>Deadline</b></td>
	 <td width="5%"><b>No. I've Completed</b></td>
	 <td width="20%"><b>Total No. Completed</b></td>
	 <td width="15%"><b>Action</b></td>
       </tr>

    <cfoutput query="myDoneSurveys">
       <tr bgColor="e3f4f6">
         <td>#myDoneSurveys.title#</td>
		 <td>#myDoneSurveys.description#</td>
	 <td><cfif myDoneSurveys.comlogo neq ''><img src="#request.webroot#/surveyengine/images/#myDoneSurveys.comlogo#" border=0>
	     <cfelse>#myDoneSurveys.comName#</cfif></td>
	 <td>#Dateformat(myDoneSurveys.deadline,"dd/mmm/yyyy")#</td>
	 <td>#myDoneSurveys.nodone#</td>
	  <cfif myDoneSurveys.NoNeeded neq 0>
             <cfset done=myDoneSurveys.NoDone/myDoneSurveys.NoNeeded * 100>
	  <cfelse>
            <cfset done=0>
	  </cfif>
	  <cfset todo=100-done>
	  <cfset left=myDoneSurveys.NoNeeded - myDoneSurveys.NoDone>
	 <td>
	  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
          <tr>
	   <td width="50%" align=left>#myDoneSurveys.NoDone# Done</td>
	   <td width="50%" align=right>#left# To Go</td>
	  </tr>
	  </table>
	  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
        
	  <tr>
	    <td style="background-color:red" width="#done#%"><cfif done GT 0>&nbsp;</cfif></td>
           <td style="background-color:green" width="#todo#%"><cfif todo GT 0>&nbsp;</cfif></td>
	  </tr>
	  </table>
	  </td>
	 <td>
	  <cfif myDoneSurveys.online GT 0>
         [<a href="#request.webroot#/members/dsp_print_survey.cfm?surveyid=#formid#" target="_blank">View Survey</a>]
	  <cfelse>
	    [<a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=28&printR=true&surveyid=#formid#" target="_blank">Print Receipt</a>]
	  </cfif>
	</td>
       </tr>
    </cfoutput>
  </table>
</cfif>

