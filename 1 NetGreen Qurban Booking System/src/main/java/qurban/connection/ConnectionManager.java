package qurban.connection;

import java.sql.*;

public class ConnectionManager {
	
	// Postgresql database
	private static String dbURL = "jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com/dc7heto636d5re?sslmode=require";
	private static String username = "dfjpxugsmxched";
	private static String password = "497a88663f8127119beaf412fe5f5bd8e31e7a671f6602afe00255356d0c40c0";
	
/*	// Oracle database
	private static String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static String username = "netgreen";
	private static String password = "system";
*/	
	public static Connection getConnection() {
		Connection connection = null;
		
		try {
			// Postgresql database
			Class.forName("org.postgresql.Driver");
			
			// Oracle database
			//Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection(dbURL, username, password);
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		}
		
		return connection;
	}
}
