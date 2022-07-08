package qurban.dao;

import java.sql.*;
import qurban.connection.ConnectionManager;
import qurban.javabean.*;

public class AnimalDetailsDAO {
	
	// Connection object
	Connection connection = null;
	
	// Animal Details attributes
	private int animalDetailsID;
	private String animalType;		// Jenis haiwan
	private double animalPrice;		// Harga seekor
	private String supplierName;	// Nama pembekal
	
	// CRUD -----------------------------------------------------------------
	
	// Create Animal Details (Create New Animal)
	public void createAnimalDetails(AnimalDetails newAnimal) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
				
			// Get values
			animalType = newAnimal.getAnimalType();
			animalPrice = newAnimal.getAnimalPrice();
			supplierName = newAnimal.getSupplierName();
				
			// Prepare SQL Statement
			PreparedStatement createSQL = connection.prepareStatement
			( "INSERT INTO animaldetails"
			+ "(animaldetailsid, animaltype, animalprice, suppliername)"
			+ "VALUES (sequence_animaldetails.nextval, ?, ?, ?)");
				
			// Set ? values
			createSQL.setString(1, animalType);
			createSQL.setDouble(2, animalPrice);
			createSQL.setString(3, supplierName);
				
			// Execute SQL
			createSQL.executeUpdate();
				
			// Check SQL
			System.out.println(createSQL);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Update Animal Details (Update Existing Animal's Details)
	public void updateAnimalDetails(AnimalDetails existingAnimal) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			animalPrice = existingAnimal.getAnimalPrice();
			supplierName = existingAnimal.getSupplierName();
			animalDetailsID = existingAnimal.getAnimalDetailsID();
			
			// Prepare SQL Statement
			PreparedStatement updateSQL = connection.prepareStatement
			( "UPDATE animaldetails "
			+ "SET animalPrice = ?, supplierName = ? "
			+ "WHERE animaldetailsid = ?");
			
			// Set ? Values
			updateSQL.setDouble(1, animalPrice);
			updateSQL.setString(2, supplierName);
			updateSQL.setInt(3, animalDetailsID);
			
			// Execute SQL
			updateSQL.executeUpdate();
			
			// Check SQL
			System.out.println(updateSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Delete Animal Details (Delete Existing Animal)
	public void deleteAnimalDetails(int animalDetailsID) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM animaldetails "
			+ "WHERE animaldetailsid = ?");
			
			// Set ? values
			deleteSQL.setInt(1, animalDetailsID);
			
			// Execute SQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
}
