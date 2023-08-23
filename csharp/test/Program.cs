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
                                Console.WriteLine("{0}", reader.GetString(0));
                            }
                        }
                    }                    
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());
            }
        }
    }
}
