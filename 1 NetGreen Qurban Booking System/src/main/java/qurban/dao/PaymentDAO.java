package qurban.dao;

import java.io.InputStream;
import java.sql.*;
import javax.servlet.http.Part;

import oracle.net.aso.d;
import qurban.connection.ConnectionManager;
import qurban.javabean.*;

public class PaymentDAO {
	
	// Connection object
	Connection connection = null;
	
	// Payment Attributes
	private int paymentID;
	private double paymentTotal;
	private Date paymentDate;
	private Part paymentReceipt;
	private InputStream inputstream;
	private int bookingID;
	
	// CRUD ---------------------------------------------------
	
	// Add Payment
	public void addPayment(Payment newPayment) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			connection.setAutoCommit(false);
			
			// Get values
			bookingID = newPayment.getBookingID();
			paymentTotal = newPayment.getPaymentTotal();
			paymentDate = newPayment.getPaymentDate();
			paymentReceipt = newPayment.getPaymentReceipt();
			inputstream = paymentReceipt.getInputStream();
			
			// Prepare SQL Statement
			PreparedStatement addSQL = connection.prepareStatement
			("INSERT INTO payment "
			+ "(paymenttotal, paymentdate, paymentreceipt, bookingid) "
			+ "VALUES (?, ?, ?, ?)");
			
			// Set ? values
			addSQL.setDouble(1, paymentTotal);
			addSQL.setDate(2, paymentDate);
			addSQL.setBlob(3, inputstream);
			addSQL.setInt(4, bookingID);
			
			// Execute SQL
			addSQL.executeUpdate();
			
			connection.commit();
			
			connection.setAutoCommit(true);
			
			// Check SQL
			System.out.println(addSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Delete Payment when Booking is deleted (For Committee only)
	public void deletePayment(int paymentID) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM payment "
			+ "WHERE paymentid = ?");
			
			// Set ? values
			deleteSQL.setInt(1, paymentID);
			
			// ExecuteSQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
