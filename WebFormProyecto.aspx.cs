using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using MySql.Data;

namespace proyecto1
{
    public partial class WebFormProyecto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cCon = "Server = 127.0.0.1; UserID = root@localhost ; Database = prueba; Password = ;";
            using (MySqlConnection con = new MySqlConnection(cCon))

            {
                con.Open();
                const string V = "SELECT * FROM usp_consulta";
                using (MySqlCommand cmd = new MySqlCommand(V, con))

                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())

                    {
                        DropDownList1.DataSource = reader;
                        DropDownList1.DataValueField = "DOC_IDENTIDAD";
                        DropDownList1.DataValueField = "EVENTO";
                        DropDownList1.DataTextField = "USUARIO";
                        DropDownList1.DataValueField = "REGISTRO_NOMINA";
                        DropDownList1.DataBind();

                    }
                }
            }    
        }
    }
}