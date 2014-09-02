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
    /// View all of the databases on the server. From here, users can create a new database,
    /// or view/edit/delete existing databases.
    /// </summary>
    public partial class databases : System.Web.UI.Page
    {
        public databases()
        {
            Page.Init += new System.EventHandler(Page_Init);
        }

        protected void Page_Load(object sender, System.EventArgs e)
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

            SqlDatabaseCollection databases = server.Databases;
            server.Disconnect();

            // Create DataSet from list of databases
            DataSet ds = new DataSet();
            ds.Tables.Add();
            ds.Tables[0].Columns.Add("name");
            ds.Tables[0].Columns.Add("encodedname");
            ds.Tables[0].Columns.Add("size");
            for (int i = 0; i < databases.Count; i++)
            {
                SqlDatabase database = databases[i];
                ds.Tables[0].Rows.Add(new object[] { Server.HtmlEncode(database.Name), Server.UrlEncode(database.Name), database.Size == -1 ? "Unknown" : String.Format("{0}MB", database.Size) });
            }
            DatabasesDataGrid.DataSource = ds;
            DatabasesDataGrid.DataBind();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                Page.ViewStateUserKey = Page.Session.SessionID;
            }
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
        }

        #region Web Form Designer generated code
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