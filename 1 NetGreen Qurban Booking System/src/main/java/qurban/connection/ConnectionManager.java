package qurban.connection;

import java.sql.*;

public class ConnectionManager {
	
	// postgresql database
	//private static String dbURL = "jdbc:postgresql://localhost/Netgreen_Qurban";
	//private static String username = "postgres";
	//private static String password = "system";
	
	// Oracle database
	private static String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static String username = "netgreen";
	private static String password = "system";
	
	public static Connection getConnection() {
		Connection connection = null;
		
		try {
			// postgresql database
			//Class.forName("org.postgresql.Driver");
			
			// Oracle database
			Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection(dbURL, username, password);
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		}
		
		return connection;
	}
}
