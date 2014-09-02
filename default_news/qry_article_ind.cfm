<cfquery name="Articles" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT Articles.*, Documents.Title
FROM Articles, Documents, DocumentArticles_Link
WHERE Articles.ArticleID = #NewsID#
AND Articles.ArticleID=DocumentArticles_Link.ArticleID
AND DocumentArticles_Link.DocumentID=Documents.DocumentID
</cfquery>