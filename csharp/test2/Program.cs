using Microsoft.Data.SqlClient;
using System.Data.SqlClient;
using System.Data;

namespace sqltest
{
    class Program
    {
        static void Main(string[] args)
        {
            string tabla = args[0]; 
            string sproc = args[1]; 
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
                    Console.WriteLine("Stored Procedure data example:");
                    Console.WriteLine("=========================================\n");
                    
                    connection.Open();       

                    String sql = sproc;

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = "@tab";
                        param.SqlDbType = SqlDbType.VarChar;
                        param.Size = 64;
                        param.Value = tabla;
                        command.Parameters.Add(param);
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
            Console.WriteLine("\nDone. Press enter.");
            Console.ReadLine(); 
        }
    }
}
