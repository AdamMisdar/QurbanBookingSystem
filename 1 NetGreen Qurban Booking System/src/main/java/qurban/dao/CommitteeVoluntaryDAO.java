package qurban.dao;

import java.sql.*;
import qurban.connection.ConnectionManager;
import qurban.javabean.*;

public class CommitteeVoluntaryDAO {
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
	double hourlyRate;
	String voluntaryRole;
	
	// CRUD -----------------------------------------------
	
	// Create/Register New Committee-Management Account
	public void createCommitteeVoluntary(Voluntary newVoluntary) throws SQLException{
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeFullName = newVoluntary.getCommitteeFullName();
			committeePhoneNum = newVoluntary.getCommitteePhoneNum();
			committeeBirthDate = newVoluntary.getCommitteeBirthDate();
			committeeAddress = newVoluntary.getCommitteeAddress();
			managerID = newVoluntary.getManagerID();
			committeeEmail = newVoluntary.getCommitteeEmail();
			committeePassword = newVoluntary.getCommitteePassword();
			hourlyRate = newVoluntary.getHourlyRate();
			voluntaryRole = newVoluntary.getVoluntaryRole();
			
			// Prepare SQL Statements
			PreparedStatement createCommitteeSQL = connection.prepareStatement
			( "INSERT INTO committee "
			+ "(committeeid, committeefullname, committeephonenum committeebirthdate, "
			+ "committeeaddress, managerID, committeeemail, committeepassword) "
			+ "VALUES (sequece_committee.nextval, ?, ?, ?, ?, ?, ?, ?)");
			
			PreparedStatement createVoluntarySQL = connection.prepareStatement
			( "INSERT INTO voluntary "
			+ "(committeeid, hourlyrate, voluntaryrole) "
			+ "VALUES (sequece_committee.currval, ?, ?)");
			
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
			createVoluntarySQL.setDouble(1, hourlyRate);
			createCommitteeSQL.setString(2, voluntaryRole);
			
			// Execute SQLs
			createCommitteeSQL.executeUpdate();
			System.out.println(createCommitteeSQL);
			
			createVoluntarySQL.executeUpdate();
			System.out.println(createVoluntarySQL);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// Update Committee Management Details (Update Existing Committee)
	public void updateCommitteeVoluntary(Voluntary existingVoluntary) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeID = existingVoluntary.getCommitteeID();
			committeeFullName = existingVoluntary.getCommitteeFullName();
			committeePhoneNum = existingVoluntary.getCommitteePhoneNum();
			committeeBirthDate = existingVoluntary.getCommitteeBirthDate();
			committeeAddress = existingVoluntary.getCommitteeAddress();
			managerID = existingVoluntary.getManagerID();
			committeeEmail = existingVoluntary.getCommitteeEmail();
			committeePassword = existingVoluntary.getCommitteePassword();
			hourlyRate = existingVoluntary.getHourlyRate();
			voluntaryRole = existingVoluntary.getVoluntaryRole();
			
			// Prepare SQL Statement
			PreparedStatement updateCommitteeSQL = connection.prepareStatement
			( "UPDATE committee "
			+ "SET committeefullname = ?, committeephonenum = ?, committeebirthdate = ?, "
			+ "committeeaddress = ?, managerid = ?, committeeemail = ?, committeePassword = ? "
			+ "WHERE committeeid = ?");
			
			PreparedStatement updateVoluntarySQL = connection.prepareStatement
			( "UPDATE voluntary "
			+ "SET hourlyrate = ?, voluntaryrole = ? "
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
			updateVoluntarySQL.setDouble(1, hourlyRate);
			updateVoluntarySQL.setString(2, voluntaryRole);
			updateVoluntarySQL.setInt(3, committeeID);
			
			// Execute SQL
			updateCommitteeSQL.executeUpdate();
			System.out.println(updateCommitteeSQL);
			
			updateVoluntarySQL.executeUpdate();
			System.out.println(updateVoluntarySQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Delete Committee-Management Account
	// TENGOK BALIK, CASCADE DELETE SEMUA BENDE ALAH
	public void deleteCommitteeVoluntary(int committeeID) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteVoluntarySQL = connection.prepareStatement
			( "DELETE FROM voluntary "
			+ "WHERE committeeid = ?");
			
			PreparedStatement deleteCommitteeSQL = connection.prepareStatement
			( "DELETE FROM committee "
			+ "WHERE committeeid = ?");
			
			// Set ? values
			deleteVoluntarySQL.setInt(1, committeeID);
			
			deleteCommitteeSQL.setInt(1, committeeID);
			
			// Execute SQL
			deleteVoluntarySQL.executeUpdate();
			System.out.println(deleteVoluntarySQL);
			
			deleteCommitteeSQL.executeUpdate();
			System.out.println(deleteCommitteeSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
}
