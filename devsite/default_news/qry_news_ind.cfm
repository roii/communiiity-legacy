<cfquery name="headlines" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM News
WHERE RecordID=#NewsID#
</cfquery>


<cfquery name="Linked" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM News
WHERE Feature=0
AND LinkID=#NewsID#
ORDER BY ArticleNumber
</cfquery>
