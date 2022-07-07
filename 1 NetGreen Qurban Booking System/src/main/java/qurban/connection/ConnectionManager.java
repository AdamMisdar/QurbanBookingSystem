package qurban.connection;

import java.sql.*;

public class ConnectionManager {
	private static String dbURL = "jdbc:postgresql://localhost/Netgreen_Qurban";
	private static String username = "postgres";
	private static String password = "system";
	
	public static Connection getConnection() {
		Connection connection = null;
		
		try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(dbURL, username, password);
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		}
		
		return connection;
	}
}
