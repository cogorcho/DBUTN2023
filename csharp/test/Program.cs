using Microsoft.Data.SqlClient;

namespace sqltest
{
    class Program
    {
        static void Main(string[] args)
        {
            try 
            { 
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

                builder.DataSource = "localhost"; 
                builder.UserID = "sa";            
                builder.Password = "Soler225";     
                builder.Password = "Soler225";     
                builder.TrustServerCertificate=true;
                builder.InitialCatalog = "dbutn";
         
                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    connection.Open();       

                    String sql = "GenTodo";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
				string sproc = reader.GetString(0);
                                Console.WriteLine("{0}", sproc);
				//crearSproc(sproc);
                            }
                        }
                    }                    
			connection.Close();
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());
            }
        }

	static void crearSproc(string sql) {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

                builder.DataSource = "localhost"; 
                builder.UserID = "sa";            
                builder.Password = "Soler225";     
                builder.Password = "Soler225";     
                builder.TrustServerCertificate=true;
                builder.InitialCatalog = "dbutn";
         
		Console.WriteLine("Ejecutando...");
		SqlConnection conn = new SqlConnection(builder.ConnectionString);
		conn.Open();
		using (SqlCommand command = new SqlCommand(sql, conn))
             	{
			command.ExecuteNonQuery();
             	}
		conn.Close();
	}
    }
}
