<cfoutput>
<cfset feed=$.getBean("feed").loadBy(name="Popular Links",siteID=$.event("siteid"))>
<cfset iterator=feed.getIterator()>

			<cfif iterator.hasNext()>
			  <ul>
			  <cfloop condition="iterator.hasNext()">
			  <cfset item=iterator.next()>
			  	<li>
			      <a href="#item.getURL()#">#HTMLEditFormat(item.getTitle())#</a>
			    </li>
			  </cfloop>
			  </ul>
			  </cfif>
</cfoutput>