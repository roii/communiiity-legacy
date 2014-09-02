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
    /// <summary>
    /// Create a new user for the database.
    /// </summary>
    public partial class CreateDatabaseUser : System.Web.UI.Page
    {
        protected void Create_Click(object sender, EventArgs e)
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
            SqlUser user = database.Users.Add(Logins.SelectedValue, Username.Text.Trim());

            server.Disconnect();
            Response.Redirect("EditDatabaseUser.aspx?database=" + Server.UrlEncode(Request.Params["database"]) + "&user=" + Server.UrlEncode(Username.Text.Trim()));
        }

        protected void Page_Load(object sender, System.EventArgs e)
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

                Logins.DataSource = server.Logins;
                Logins.DataBind();


                // Remove existing users from the Logins selection
                foreach (SqlUser user in database.Users)
                {
                    ListItem item = Logins.Items.FindByValue(user.Login);
                    if (item != null)
                        Logins.Items.Remove(item);
                }

                if (Logins.Items.Count == 0)
                {
                    CreateButton.Enabled = false;
                    ErrorMessage.Text = "All Logins are Users of this database.";
                }

                Username.Text = Logins.SelectedValue;

                server.Disconnect();
            }
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        }
        #endregion
    }
}
