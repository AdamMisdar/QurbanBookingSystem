package qurban.dao;

import java.sql.*;
import qurban.connection.ConnectionManager;
import qurban.javabean.*;

public class BookingDAO {
	
	// Connection object
	Connection connection = null;
	
	// Booking attributes
	private int bookingID;
	private Date bookingDate;
	private int clientID;
	private int committeeID;
	
	// CRUD ---------------------------------------------------------
	
	// Create Booking (Client only) // When Client press button create booking
	public int createBooking(Booking newBooking) {
		int booking_id = 0;;
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			bookingDate = newBooking.getBookingDate();
			clientID = newBooking.getClientID();
			
			// Prepare SQL Statement
			PreparedStatement createSQL = connection.prepareStatement
			( "INSERT INTO booking "
			+ "(bookingid, bookingdate, clientid) "
			+ "VALUES (sequence_booking.nextval, ?, ?)");
			
			// Set ? values
			createSQL.setDate(1, bookingDate);
			createSQL.setInt(2, clientID);
			
			// Execute SQL
			createSQL.executeUpdate();
			
			// Check SQL
			System.out.println(createSQL);
			
			//PrepareStatement select ------------	
			PreparedStatement selectSQL = connection.prepareStatement
			( "SELECT bookingid, clientid "
			+ "FROM booking "
			+ "WHERE clientid = ? "
			+ "ORDER BY bookingid");
			
			// Set ? values
			selectSQL.setInt(1, clientID);
			
			// Execute SQL
			ResultSet result = selectSQL.executeQuery();
		
			// Assign booking id
			while(result.next()) {
				booking_id = result.getInt("bookingid");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Return id
		return booking_id;
	}
	
	// Delete Booking (Committee)
	public void deleteBooking(int bookingID) {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM booking "
			+ "WHERE bookingid = ?");
			
			// Set ? values
			deleteSQL.setInt(1, bookingID);
			
			// ExecuteSQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
		
}
