<%@ Register TagPrefix="Toolbar" TagName="Server" Src="Toolbars/ServerToolbar.ascx" %>
<%@ Register TagPrefix="Location" TagName="Server" Src="Toolbars/ServerLocation.ascx" %>
<%@ Register TagPrefix="Toolbar" TagName="HelpLogout" Src="Toolbars/HelpLogoutToolbar.ascx" %>

<%@ Page Language="c#" Inherits="SqlWebAdmin.CreateLogin" CodeFile="CreateLogin.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Web Data Administrator - Create Login</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0">
    <form id="CreateDatabase" method="post" runat="server">
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
                <td bgcolor="#6699ff" valign="top" align="center" width="172" height="100%">
                    <Toolbar:Server runat="server" ID="ServerToolbar"></Toolbar:Server>
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
                                            CREATE LOGIN
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
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="databaseListItem">
                                                        Authentication Method:
                                                    </td>
                                                    <td class="databaseListItem">
                                                        <asp:DropDownList ID="AuthType" AutoPostBack="True" OnSelectedIndexChanged="AuthType_Changed"
                                                            runat="server">
                                                            <asp:ListItem Value="NTUser">Windows Integrated</asp:ListItem>
                                                            <asp:ListItem Value="Standard">Sql Login</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="databaseListItem">
                                                        Login Name:
                                                    </td>
                                                    <td class="databaseListItem">
                                                        <asp:TextBox ID="LoginName" Columns="35" MaxLength="128" runat="server" />
                                                        <asp:RequiredFieldValidator ControlToValidate="LoginName" ErrorMessage="* Required"
                                                            Display="Dynamic" runat="server" ID="RequiredFieldValidator1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="databaseListItem">
                                                        <asp:Label ID="PasswordLabel" Enabled="False" runat="server">Password:</asp:Label>
                                                    </td>
                                                    <td class="databaseListItem">
                                                        <asp:TextBox ID="Password" Columns="35" Enabled="False" MaxLength="128" TextMode="Password"
                                                            runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="right" class="databaseListItem">
                                                        <asp:Button Text="Create Login" CssClass="Button" OnClick="AddLogin_Click" runat="server"
                                                            ID="Button1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" class="databaseListItem">
                                                        <asp:Label ID="ErrorMessage" ForeColor="Red" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
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
