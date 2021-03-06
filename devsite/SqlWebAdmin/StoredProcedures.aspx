<%@ Register TagPrefix="Toolbar" TagName="HelpLogout" Src="Toolbars/HelpLogoutToolbar.ascx" %>
<%@ Register TagPrefix="Toolbar" TagName="Database" Src="Toolbars/DatabaseToolbar.ascx" %>
<%@ Register TagPrefix="Toolbar" TagName="Server" Src="Toolbars/ServerToolbar.ascx" %>
<%@ Register TagPrefix="Location" TagName="Server" Src="Toolbars/ServerLocation.ascx" %>
<%@ Register TagPrefix="Location" TagName="Database" Src="Toolbars/DatabaseLocation.ascx" %>

<%@ Page Language="c#" Inherits="SqlWebAdmin.StoredProcedures" CodeFile="StoredProcedures.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Web Data Administrator - Stored Procedures</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0">
    <form id="WebForm1" method="post" runat="server">
        <table style="width: 100%; height: 62" cellspacing="0" cellpadding="0" border="0">
            <!-- FIRST ROW: HEADER -->
            <tr>
                <td colspan="3" valign="bottom" align="left" width="100%" height="36" background="images/bg_horizontal_top_right.gif"
                    background-repeat="repeat-x" bgcolor="#c0c0c0">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <!--BEGIN ONE LINE-->
                            <td valign="bottom" width="308">
                                <img src="images/logo_top.gif" width="308" height="36" alt="" border="0"></td>
                            <!--END ONE LINE-->
                            <td valign="bottom" align="right" width="100%">
                                <Toolbar:HelpLogout runat="server" ID="HelpLogout" HelpTopic="login"></Toolbar:HelpLogout>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- FIRST ROW: HEADER -->
            <!-- SECOND ROW: CRUMBS -->
            <tr>
                <!--BEGIN ONE LINE-->
                <td align="left" bgcolor="#b4c6f3" background="images/blue_back.gif" width="172"
                    height="26">
                    <img src="images/logo_bottom.gif" width="238" height="26" alt="" border="0"></td>
                <!--END ONE LINE-->
                <td align="left" bgcolor="#b4c6f3" background="images/blue_back.gif" width="100%"
                    height="26">
                    <table width="100%" height="26" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed">
                        <tr>
                            <td width="12">
                                &nbsp;
                            </td>
                            <td valign="center" align="left" width="100%" height="26">
                                <Location:Server runat="Server" ID="ServerLocation"></Location:Server>
                                <Location:Database runat="Server" ID="DatabaseLocation"></Location:Database>
                            </td>
                        </tr>
                    </table>
                </td>
                <!--BEGIN ONE LINE-->
                <td align="left" bgcolor="#b4c6f3" width="12" height="26">
                    <img src="images/blue_back_right.gif" width="12" height="26" alt="" border="0"></td>
                <!--END ONE LINE-->
            </tr>
        </table>
        <!-- SECOND ROW: CRUMBS -->
        <!-- THIRD ROW: BOTTOM SECTION -->
        <table style="width: 100%; height: 100%; padding: 0px; border: 0px" cellspacing="0">
            <tr>
                <!-- START NAVIGATION SECTION -->
                <td bgcolor="#6699ff" valign="top" align="middle" width="172" height="100%">
                    <Toolbar:Server runat="server" ID="ServerToolbar"></Toolbar:Server>
                    <Toolbar:Database Selected="StoredProcedures" runat="server" ID="DatabaseToolbar"></Toolbar:Database>
                </td>
                <!-- END NAVIGATION SECTION -->
                <!-- START CONTENT SECTION -->
                <td valign="top" align="left">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr>
                            <!--BEGIN ONE LINE-->
                            <td valign="bottom" colspan="2" height="8" width="100%">
                                <img src="images/spacer.gif" width="1" height="8" alt="" border="0"></td>
                            <!--END ONE LINE-->
                        </tr>
                        <tr>
                            <!--BEGIN ONE LINE-->
                            <td align="left" width="12">
                                <img src="images/spacer.gif" width="12" height="1" alt="" border="0"></td>
                            <!--END ONE LINE-->
                            <td align="left" class="databaseListItem" width="100%">
                                <!-- PAGE CONTENT: START -->
                                <!-- SECTION HEADER: START -->
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td class="databaseListHeader">
                                            STORED PROCEDURES
                                        </td>
                                    </tr>
                                    <!-- SECTION HEADER: END -->
                                    <!-- SECTION: START -->
                                    <tr>
                                        <!--BEGIN ONE LINE-->
                                        <td height="3" valign="middle" background="images/blue_dotted_line.gif">
                                            <img src="images/blue_dotted_line.gif" width="150" height="3" alt="" border="0"></td>
                                        <!--END ONE LINE-->
                                    </tr>
                                    <tr>
                                        <!--BEGIN ONE LINE-->
                                        <td height="4" valign="middle">
                                            <img src="images/spacer.gif" width="1" height="4" alt="" border="0"></td>
                                        <!--END ONE LINE-->
                                    </tr>
                                    <tr>
                                        <td bgcolor="white" class="databaseListItem">
                                            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                                <tr>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="SProcTypeDropDownList">
                                                            <asp:ListItem Value="Show User Stored Procedures Only">User Stored Procedures Only</asp:ListItem>
                                                            <asp:ListItem Value="Show User and System Stored Procedures">User and System Stored Procedures</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Button ID="FilterSProcsButton" runat="server" Text="Filter" CssClass="button"
                                                            onMouseOver="this.style.color='#808080';" onMouseOut="this.style.color='#000000';"
                                                            OnClick="FilterSProcsButton_Click"></asp:Button>
                                                    </td>
                                                    <td align="right">
                                                        <asp:HyperLink runat="server" CssClass="createLink" ID="AddNewSProcHyperLink"><img src="images/new.gif" width="16" height="16" alt="" border="0">
                                                            <span style="position:relative; top: -3px;">Create new stored procedure</span></asp:HyperLink>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br>
                                            <asp:DataGrid ID="SProcsDataGrid" runat="server" GridLines="None" Border="0" AutoGenerateColumns="False"
                                                Width="100%" CellPadding="4" CellSpacing="1">
                                                <HeaderStyle CssClass="tableHeader"></HeaderStyle>
                                                <ItemStyle CssClass="tableItems"></ItemStyle>
                                                <Columns>
                                                    <asp:TemplateColumn HeaderText="Name">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                        <ItemTemplate>
                                                            <a href='<%# String.Format("editstoredprocedure.aspx?database={0}&sproc={1}", Server.UrlEncode(Request["database"]), DataBinder.Eval(Container.DataItem, "encodedname")) %>'>
                                                                <img src="images/sproc_ico.gif" border="0" align="absmiddle"></a> &nbsp;
                                                            <asp:HyperLink ID="Hyperlink1" runat="server" Text='<%# "&amp;nbsp;" + DataBinder.Eval(Container.DataItem, "name") %>'
                                                                CssClass="databaseListBlack" NavigateUrl='<%# String.Format("editstoredprocedure.aspx?database={0}&sproc={1}", Server.UrlEncode(Request["database"]), DataBinder.Eval(Container.DataItem, "encodedname")) %>'></asp:HyperLink>
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
                                                    <asp:BoundColumn DataField="owner" HeaderText="Owner" DataFormatString="{0}">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </asp:BoundColumn>
                                                    <asp:TemplateColumn HeaderText="Type">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                        <ItemTemplate>
                                                            <%# DataBinder.Eval(Container.DataItem, "type") %>
                                                            &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
                                                    <asp:BoundColumn DataField="createdate" HeaderText="Create Date" DataFormatString="{0}">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </asp:BoundColumn>
                                                    <asp:TemplateColumn HeaderText="Edit">
                                                        <HeaderStyle Wrap="False" HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="EditSProc" runat="server" Text="edit" CssClass="databaseListAction"
                                                                NavigateUrl='<%# String.Format("editstoredprocedure.aspx?database={0}&sproc={1}", Server.UrlEncode(Request["database"]), DataBinder.Eval(Container.DataItem, "encodedname")) %>'></asp:HyperLink>
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
                                                    <asp:TemplateColumn HeaderText="Delete">
                                                        <HeaderStyle Wrap="False" HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="DeleteSProc" runat="server" Text="delete" CssClass="databaseListAction"
                                                                NavigateUrl='<%# String.Format("deletestoredprocedure.aspx?database={0}&sproc={1}", Server.UrlEncode(Request["database"]), DataBinder.Eval(Container.DataItem, "encodedname")) %>'></asp:HyperLink>
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
                                                </Columns>
                                            </asp:DataGrid>
                                            <asp:Label ID="SProcTypeErrorLabel" runat="server" EnableViewState="False" Font-Bold="true"
                                                Font-Size="10">There are no stored procedures to display.</asp:Label>
                                        </td>
                                    </tr>
                                    <!-- Section END -->
                                    <!-- Section Footer START -->
                                </table>
                                <br>
                                <!-- Section Footer END -->
                                <!-- Page content END -->
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- THIRD ROW: BOTTOM SECTION -->
        </table>
    </form>
</body>
</html>
