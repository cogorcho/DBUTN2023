import java.sql.*;  

class Test{  
    public static void main(String args[]){  
        try{  
            Class.forName("com.mysql.jdbc.Driver");  
            Connection con=DriverManager.getConnection(  
            "jdbc:mysql://localhost:3306/UTN","db2023","db2023");  

            String sproc = "";
            CallableStatement cstmt;
            ResultSet rs;
            String tablas = "select table_name from information_schema.tables where table_schema = 'UTN'";
            Statement stmt = con.createStatement();
            ResultSet rst = stmt.executeQuery(tablas);

            while (rst.next()) {
                String param = rst.getString(1);

                sproc = "call geninsert(?)";
                System.out.println("Select 'sproc "+ "-> I_" + param + "';");
                cstmt = con.prepareCall(sproc);
                cstmt.setString(1,param);
                rs=cstmt.executeQuery();  
                while(rs.next())  
                    System.out.println(rs.getString(1));

                sproc = "call genupdate(?)";
                System.out.println("Select 'sproc "+ "-> U_" + param + "';");
                cstmt = con.prepareCall(sproc);
                cstmt.setString(1,param);
                rs=cstmt.executeQuery();  
                while(rs.next())  
                    System.out.println(rs.getString(1));  
    
                sproc = "call gendelete(?)";
                System.out.println("Select 'sproc "+ "-> D_" + param + "';");
                cstmt = con.prepareCall(sproc);
                cstmt.setString(1,param);
                rs=cstmt.executeQuery();  
                while(rs.next())  
                    System.out.println(rs.getString(1));
            }
            con.close();  
        } catch(Exception e) { 
            System.out.println(e);
        }  
    }  
}  
