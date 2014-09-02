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
    /// Summary description for ServerRoles.
    /// </summary>
    public partial class ServerRoles : System.Web.UI.Page
    {
        protected System.Web.UI.WebControls.DataGrid LoginDataGrid;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            SqlServer server = SqlServer.CurrentServer;
            SqlAdmin.SqlServerRole serverRole;
            try
            {
                server.Connect();
            }
            catch (System.Exception ex)
            {
                //Response.Redirect("Error.aspx?errorPassCode=" + 2002);
                Response.Redirect(String.Format("error.aspx?errormsg={0}&stacktrace={1}", Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace)));
            }
            SqlServerRoleCollection serverRoles = server.Roles;
            server.Disconnect();

            // Create DataSet from list of databases
            DataSet ds = new DataSet();
            ds.Tables.Add();
            ds.Tables[0].Columns.Add("FullName");
            ds.Tables[0].Columns.Add("Name");
            ds.Tables[0].Columns.Add("Description");

            for (int i = 0; i < serverRoles.Count; i++)
            {

                serverRole = serverRoles[i];

                ds.Tables[0].Rows.Add(
                    new object[] {
                        Server.HtmlEncode(serverRole.FullName), 
                        Server.HtmlEncode(serverRole.Name),
                        Server.HtmlEncode(serverRole.Description),}
                );
            }

            RoleDataGrid.DataSource = ds;
            RoleDataGrid.DataBind();
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
