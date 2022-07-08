package qurban.javabean;

import java.sql.Date;

public abstract class Committee {
	int committeeID;
	String committeeFullName;
	String committeePhoneNum;
	Date committeeBirthDate;
	String committeeAddress;
	int managerID;
	String committeeEmail;
	String committeePassword;
	
	// Constructor ------------------
	
	// default
	public Committee() {
		
	}
	
	// with ID
	public Committee(int ID, String name, String phoneNum, Date date, 
			String address, int manID, String email, String password) {
		
		committeeID = ID;
		committeeFullName = name;
		committeePhoneNum = phoneNum;
		committeeBirthDate = date;
		committeeAddress = address;
		managerID = manID;
		committeeEmail = email;
		committeePassword = password;
	}
	
	// without ID
	public Committee(String name, String phoneNum, Date date, 
			String address, int manID, String email, String password) {
		
		committeeFullName = name;
		committeePhoneNum = phoneNum;
		committeeBirthDate = date;
		committeeAddress = address;
		managerID = manID;
		committeeEmail = email;
		committeePassword = password;
	}
	
	
	// Setter -------------------------------
	public void setCommitteeID(int ID) {
		committeeID = ID;
	}
	public void setCommitteeFullName(String name) {
		committeeFullName = name;
	}
	public void setCommitteePhoneNum(String phoneNum) {
		committeePhoneNum = phoneNum;
	}
	public void setCommitteeBirthDate(Date date) {
		committeeBirthDate = date;
	}
	public void setCommitteeAddress(String address) {
		committeeAddress = address;
	}
	public void setManagerID(int manID) {
		managerID = manID;
	}
	public void setCommitteeEmail(String email) {
		committeeEmail = email;
	}
	public void setCommitteePassword(String password) {
		committeePassword = password;
	}
	
	// Getter ------------------------------
	public int getCommitteeID() {
		return committeeID;
	}
	public String getCommitteeFullName() {
		return committeeFullName;
	}
	public String getCommitteePhoneNum() {
		return committeePhoneNum;
	}
	public Date getCommitteeBirthDate() {
		return committeeBirthDate;
	}
	public String getCommitteeAddress() {
		return committeeAddress;
	}
	public int getManagerID() {
		return managerID;
	}
	public String getCommitteeEmail() {
		return committeeEmail;
	}
	public String getCommitteePassword() {
		return committeePassword;
	}
	
	
}
