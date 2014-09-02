<cfoutput>
	<div class="outer level#level# #class#">
		<div class="inner">
			<dl id="comment-#request['rsSubComments#level#'].commentid#">
				<dt>
					<cite class="fn">
						<cfif request['rsSubComments#level#'].url neq ''>
							<a class="url" href="#request['rsSubComments#level#'].url#" target="_blank">#htmleditformat(request['rsSubComments#level#'].name)#</a>
						<cfelse>
							#htmleditformat(request['rsSubComments#level#'].name)#
						</cfif>
					</cite>
					<span class="says">says:</span>
<!---					<cfif request.isEditor and request['rsSubComments#level#'].email neq ''>
						<a href="javascript:noSpam('#listFirst(htmlEditFormat(request['rsSubComments#level#'].email),'@')#','#listlast(HTMLEditFormat(request['rsSubComments#level#'].email),'@')#')" onfocus="this.blur();">#$.rbKey('comments.email')#</a>
					</cfif>
					<cfif request.isEditor>
						<cfif yesnoformat(application.configBean.getValue("editablecomments"))>
							| <a class="editcomment" data-id="#request['rsSubComments#level#'].commentID#">#$.rbKey('comments.edit')#</a>
						</cfif>
						<cfif request['rsSubComments#level#'].isApproved neq 1>
							| <a href="./?approvedcommentid=#request['rsSubComments#level#'].commentid#&nocache=1&linkServID=#$.content('contentID')#" onClick="return confirm('Approve Comment?');">#$.rbKey('comments.approve')#</a>
						</cfif>
						| <a href="./?deletecommentid=#request['rsSubComments#level#'].commentid#&nocache=1&linkServID=#$.content('contentID')#" onClick="return confirm('Delete Comment?');">#$.rbKey('comments.delete')#</a>		
					</cfif>
--->
				</dt>
				<dd class="dateTime">
					#LSDateFormat(request['rsSubComments#level#'].entered,"long")#, #LSTimeFormat(request['rsSubComments#level#'].entered,"short")#
				</dd>
				<cfif level eq 0>
					<cfif len($.currentUser().getPhotoFileID())>
						<dd class="gravatar"><img src="#$.createHREFForImage($.currentUser().getSiteID(),$.currentUser().getPhotoFileID(),'jpg', 'small')#" /></dd>
					<cfelse>
						<dd class="gravatar"><img src="http://www.gravatar.com/avatar/#lcase(Hash(lcase(request['rsSubComments#level#'].email)))#" width="32" height="32" /></dd>
					</cfif>
				<cfelse>
					<cfif len($.currentUser().getPhotoFileID())>
						<dd class="gravatar"><img src="#$.createHREFForImage($.currentUser().getSiteID(),$.currentUser().getPhotoFileID(),'jpg', 'medium')#" /></dd>
					<cfelse>
						<dd class="gravatar"><img src="http://www.gravatar.com/avatar/#lcase(Hash(lcase(request['rsSubComments#level#'].email)))#" width="50" height="50" /></dd>
					</cfif>
				</cfif>
				<dd class="comment">
					#setParagraphs(htmleditformat(request['rsSubComments#level#'].comments))#
				</dd>
				<dd class="reply"><a  data-id="#request['rsSubComments#level#'].commentid#" href="##postcomment">#$.rbKey('comments.reply')#</a></dd>
				<dd id="postcomment-#request['rsSubComments#level#'].commentid#"></dd>
			</dl>
		</div>
	</div>
</cfoutput>