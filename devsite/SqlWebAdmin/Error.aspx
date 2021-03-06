<%@ Register TagPrefix="Toolbar" TagName="Server" Src="Toolbars/ServerToolbar.ascx" %>
<%@ Register TagPrefix="Toolbar" TagName="HelpLogout" Src="Toolbars/HelpLogoutToolbar.ascx" %>

<%@ Page Language="c#" Inherits="SqlWebAdmin.Error" CodeFile="Error.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Web Data Administrator - Error</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0">
    <form method="post" runat="server">
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
                    style="height: 26px">
                    <img src="images/logo_bottom.gif" width="238" height="26" alt="" border="0"></td>
                <!--END ONE LINE-->
                <td align="left" bgcolor="#b4c6f3" background="images/blue_back.gif" width="100%"
                    style="height: 26px">
                    <table width="100%" height="26" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed">
                        <tr>
                            <td width="12">
                                &nbsp;
                            </td>
                            <td valign="center" align="left" width="100%" height="26">
                            </td>
                        </tr>
                    </table>
                </td>
                <!--BEGIN ONE LINE-->
                <td align="left" bgcolor="#b4c6f3" width="12" style="height: 26px">
                    <img src="images/blue_back_right.gif" width="12" height="26" alt="" border="0"></td>
                <!--END ONE LINE-->
            </tr>
        </table>
        <!-- SECOND ROW: CRUMBS -->
        <!-- THIRD ROW: BOTTOM SECTION -->
        <table style="width: 100%; height: 100%; padding: 0px; border: 0px" cellspacing="0">
            <tr>
                <td style="width: 195px" valign="top">
                    <table style="width: 172px; height: 100%; padding: 0px; border: 0px" cellspacing="0">
                        <tr>
                            <!-- START NAVIGATION SECTION -->
                            <td bgcolor="#6699ff" valign="top" align="middle" width="172" height="100%">
                                <Toolbar:Server runat="server" ID="ServerToolbar"></Toolbar:Server>
                            </td>
                        </tr>
                        <!-- END NAVIGATION SECTION -->
                    </table>
                </td>
                <!-- START CONTENT SECTION -->
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" border="0" width="600">
                        <tr>
                            <!--BEGIN ONE LINE-->
                            <td valign="bottom" colspan="2" height="20" width="100%">
                                <img src="images/spacer.gif" width="1" height="20" alt="" border="0" /></td>
                            <!--END ONE LINE-->
                        </tr>
                        <tr>
                            <td>
                                <img src="images/spacer.gif" width="10" height="8" alt="" border="0" />
                            </td>
                            <td valign="top" align="center">
                                <table cellspacing="0" cellpadding="0" border="0" width="100%" style="background-image: url(images/bg_error.gif);
                                    background-repeat: repeat;">
                                    <tr>
                                        <!--BEGIN ONE LINE-->
                                        <td valign="bottom" colspan="2" height="20" width="100%">
                                            <img src="images/spacer.gif" width="1" height="20" alt="" border="0" /></td>
                                        <!--END ONE LINE-->
                                    </tr>
                                    <tr>
                                        <!--BEGIN ONE LINE-->
                                        <td align="left" width="12" style="height: 83px">
                                            <img src="images/spacer.gif" width="12" height="1" alt="" border="0" /></td>
                                        <!--END ONE LINE-->
                                        <td align="left" class="databaseListItem" width="100%" style="height: 83px">
                                            <!-- PAGE CONTENT: START -->
                                            <!-- SECTION HEADER: START -->
                                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td class="databaseListHeader" valign="center">
                                                        <img src="images/ico_error.gif" />ERROR
                                                    </td>
                                                </tr>
                                                <!-- SECTION HEADER: END -->
                                                <!-- SECTION: START -->
                                                <tr>
                                                    <!--BEGIN ONE LINE-->
                                                    <td height="3" valign="center" background="images/blue_dotted_line.gif">
                                                        <img src="images/blue_dotted_line.gif" width="150" height="3" alt="" border="0" /></td>
                                                    <!--END ONE LINE-->
                                                </tr>
                                                <tr>
                                                    <!--BEGIN ONE LINE-->
                                                    <td height="4" valign="center">
                                                        <img src="images/spacer.gif" width="1" height="4" alt="" border="0"></td>
                                                    <!--END ONE LINE-->
                                                </tr>
                                                <tr>
                                                    <td class="databaseListItem">
                                                        <asp:Label ID="ErrorLabel" runat="server"></asp:Label>
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
                                    <tr>
                                        <!--BEGIN ONE LINE-->
                                        <td height="4" valign="center">
                                            <img src="images/spacer.gif" width="1" height="10" alt="" border="0"></td>
                                        <!--END ONE LINE-->
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <img src="images/spacer.gif" width="50" height="8" alt="" border="0" />
                            </td>
                        </tr>
                    </table>
                </td>
                <!-- THIRD ROW: BOTTOM SECTION -->
            </tr>
        </table>
    </form>
</body>
</html>
