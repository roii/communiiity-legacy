//=====================================================================
//
// THIS CODE AND INFORMATION IS PROVIDED TO YOU FOR YOUR REFERENTIAL
// PURPOSES ONLY, AND IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE,
// AND MAY NOT BE REDISTRIBUTED IN ANY MANNER.
//
// Copyright (C) 2003  Microsoft Corporation.  All rights reserved.
//
//=====================================================================
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using SqlAdmin;

namespace SqlWebAdmin
{
    public partial class DatabaseRoles : System.Web.UI.Page
    {
        //protected HyperLink CreateRoleLink;

        protected override void OnLoad(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SqlServer server = SqlServer.CurrentServer;
                try
                {
                    server.Connect();
                }
                catch (System.Exception ex)
                {
                    //Response.Redirect("Error.aspx?errorPassCode=" + 2002);
                    Response.Redirect(String.Format("error.aspx?errormsg={0}&stacktrace={1}", Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace)));
                }

                SqlDatabase database = SqlDatabase.CurrentDatabase(server);

                RolesGrid.DataSource = database.DatabaseRoles;
                RolesGrid.DataBind();

                //CreateRoleLink.NavigateUrl = "CreateDatabaseRole.aspx?database=" + Server.UrlEncode(Request["database"]);

                server.Disconnect();
            }
            base.OnLoad(e);
        }
    }
}
