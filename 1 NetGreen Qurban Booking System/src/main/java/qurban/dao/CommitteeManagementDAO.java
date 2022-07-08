package qurban.dao;

import java.sql.*;
import qurban.connection.*;
import qurban.javabean.*;

public class CommitteeManagementDAO {
	
	// Connection object
	Connection connection = null;
	
	// Committee-Management Attributes
	int committeeID;
	String committeeFullName;
	String committeePhoneNum;
	Date committeeBirthDate;
	String committeeAddress;
	int managerID;
	String committeeEmail;
	String committeePassword;
	String managementPosition;
	
	// CRUD -----------------------------------------------
	
	// Create/Register New Committee-Management Account
	public void createCommitteeManagement(Management newManagement) throws SQLException{
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeFullName = newManagement.getCommitteeFullName();
			committeePhoneNum = newManagement.getCommitteePhoneNum();
			committeeBirthDate = newManagement.getCommitteeBirthDate();
			committeeAddress = newManagement.getCommitteeAddress();
			managerID = newManagement.getManagerID();
			committeeEmail = newManagement.getCommitteeEmail();
			committeePassword = newManagement.getCommitteePassword();
			managementPosition = newManagement.getManagementPosition();
			
			// Prepare SQL Statements
			PreparedStatement createCommitteeSQL = connection.prepareStatement
			( "INSERT INTO committee "
			+ "(committeeid, committeefullname, committeephonenum committeebirthdate, "
			+ "committeeaddress, managerID, committeeemail, committeepassword) "
			+ "VALUES (sequece_committee.nextval, ?, ?, ?, ?, ?, ?, ?)");
			
			PreparedStatement createManagementSQL = connection.prepareStatement
			( "INSERT INTO management "
			+ "(committeeid, managementposition) "
			+ "VALUES (sequece_committee.currval, ?)");
			
			// Set ? values
			// ? Committee
			createCommitteeSQL.setString(1, committeeFullName);
			createCommitteeSQL.setString(2, committeePhoneNum);
			createCommitteeSQL.setDate(3, committeeBirthDate);
			createCommitteeSQL.setString(4, committeeAddress);
			createCommitteeSQL.setInt(5, managerID);
			createCommitteeSQL.setString(6, committeeEmail);
			createCommitteeSQL.setString(7, committeePassword);
			
			// ? Management
			createManagementSQL.setString(1, managementPosition);
			
			// Execute SQLs
			createCommitteeSQL.executeUpdate();
			System.out.println(createCommitteeSQL);
			
			createManagementSQL.executeUpdate();
			System.out.println(createManagementSQL);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// Update Committee Management Details (Update Existing Committee)
	public void updateCommitteeManagement(Management existingManagement) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeID = existingManagement.getCommitteeID();
			committeeFullName = existingManagement.getCommitteeFullName();
			committeePhoneNum = existingManagement.getCommitteePhoneNum();
			committeeBirthDate = existingManagement.getCommitteeBirthDate();
			committeeAddress = existingManagement.getCommitteeAddress();
			managerID = existingManagement.getManagerID();
			committeeEmail = existingManagement.getCommitteeEmail();
			committeePassword = existingManagement.getCommitteePassword();
			managementPosition = existingManagement.getManagementPosition();
			
			// Prepare SQL Statement
			PreparedStatement updateCommitteeSQL = connection.prepareStatement
			( "UPDATE committee "
			+ "SET committeefullname = ?, committeephonenum = ?, committeebirthdate = ?, "
			+ "committeeaddress = ?, managerid = ?, committeeemail = ?, committeePassword = ? "
			+ "WHERE committeeid = ?");
			
			PreparedStatement updateManagementSQL = connection.prepareStatement
			( "UPDATE management "
			+ "SET managementposition = ? "
			+ "WHERE committeeid = ?");
			
			// Set ? Values
			// ? Committee
			updateCommitteeSQL.setString(1, committeeFullName);
			updateCommitteeSQL.setString(2, committeePhoneNum);
			updateCommitteeSQL.setDate(3, committeeBirthDate);
			updateCommitteeSQL.setString(4, committeeAddress);
			updateCommitteeSQL.setInt(5, managerID);
			updateCommitteeSQL.setString(6, committeeEmail);
			updateCommitteeSQL.setString(7, committeePassword);
			updateCommitteeSQL.setInt(8, committeeID);
			
			// ? Management
			updateManagementSQL.setString(1, managementPosition);
			updateManagementSQL.setInt(2, committeeID);
			
			
			// Execute SQL
			updateCommitteeSQL.executeUpdate();
			System.out.println(updateCommitteeSQL);
			
			updateManagementSQL.executeUpdate();
			System.out.println(updateManagementSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Delete Committee-Management Account
	// TENGOK BALIK, CASCADE DELETE SEMUA BENDE ALAH
	public void deleteCommitteeManagement(int committeeID) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteManagementSQL = connection.prepareStatement
			( "DELETE FROM management "
			+ "WHERE committeeid = ?");
			
			PreparedStatement deleteCommitteeSQL = connection.prepareStatement
			( "DELETE FROM committee "
			+ "WHERE committeeid = ?");
			
			// Set ? values
			deleteManagementSQL.setInt(1, committeeID);
			deleteCommitteeSQL.setInt(1, committeeID);
			
			// Execute SQL
			deleteManagementSQL.executeUpdate();
			System.out.println(deleteManagementSQL);
			
			deleteCommitteeSQL.executeUpdate();
			System.out.println(deleteCommitteeSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	
}
