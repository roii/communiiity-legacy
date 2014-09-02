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
    public partial class EditDatabaseUser : System.Web.UI.Page
    {
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("DatabaseUsers.aspx?database=" + Server.UrlEncode(Request["Database"]));
        }

        protected void Save_Click(object sender, EventArgs e)
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

            try
            {
                SqlDatabase database = SqlDatabase.CurrentDatabase(server);

                SqlDatabaseRoleCollection dbRoles = database.DatabaseRoles;
                SqlUser user = database.Users[Request["user"]];

                foreach (ListItem item in Roles.Items)
                {
                    if (!user.IsMember(item.Value) && item.Selected)
                    {
                        dbRoles[item.Value].AddMember(Request["user"]);
                    }
                    else if (user.IsMember(item.Value) && !item.Selected)
                    {
                        dbRoles[item.Value].DropMember(Request["user"]);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorMessage.Text = ex.Message;
                return;
            }
            finally
            {
                server.Disconnect();
            }

            Response.Redirect("DatabaseUsers.aspx?database=" + Server.UrlEncode(Request["database"]));
        }

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

                SqlUser user = null;
                if (Request["User"] != null)
                {
                    user = database.Users[Request["User"]];
                }
                if (user == null)
                    Response.Redirect("DatabaseUsers.aspx");

                UsernameLabel.Text = user.Name.ToUpper();
                LoginLabel.Text = user.Login;

                SqlDatabaseRoleCollection dbRoles = database.DatabaseRoles;

                Roles.DataSource = dbRoles;
                Roles.DataBind();

                foreach (string roleName in user.ListMembers())
                {
                    ListItem roleItem = Roles.Items.FindByValue(roleName);
                    if (roleItem != null)
                    {
                        roleItem.Selected = true;
                    }
                }

                server.Disconnect();
            }

            base.OnLoad(e);
        }
    }
}
