import java.sql.*;  
import java.io.*;  
import java.util.stream.*;
import java.util.Set;
import java.util.Iterator;

class Gen {  
    public static void main(String args[]) {  
        try {  
		Conn conn = new Conn();
		conn.db = "UTN";
		conn.host = "localhost";
		conn.port = "3306";
		conn.user = "db2023";
		conn.passwd = "db2023";
		conn.strdriver = "jdbc:mysql://";
            	conn.driver = "com.mysql.cj.jdbc.Driver";
		System.out.println(conn.connstr() + ", " + conn.user + ", " + conn.passwd);
		Class.forName(conn.driver);
		Connection con = DriverManager.getConnection(conn.connstr(), conn.user, conn.passwd);
		System.out.println("Conectado a " + conn.db);
            	con.close();  
        } catch(Exception e) { 
            System.out.println(e);
        }  

	Iterator<String> itr = listFilesUsingJavaIO("/home/juan/dev/dbutn/mysql/tablas").iterator();
	// traversing over HashSet
	System.out.println("Traversing over Set using Iterator");
	while(itr.hasNext()) {
		System.out.println(itr.next());
	}

    }  
	public static Set<String> listFilesUsingJavaIO(String dir) {
		return Stream.of(new File(dir).listFiles())
		.filter(file -> !file.isDirectory())
		.map(File::getName)
		.collect(Collectors.toSet());
	}
}  
