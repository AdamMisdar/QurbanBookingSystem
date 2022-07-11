package qurban.javabean;

public class AnimalOrder {
	
	int animalOrderID;
	String animalPartType;		// Jenis haiwan untuk 1 bahagian
	String dependentName;		// Nama yg dikorbankan
	int bookingID;
	
	// Constructors -------------------------------
	
	//default
	public AnimalOrder() {
		
	}
	
	// with ID
	public AnimalOrder(int animalOrderID, String animalPartType, String dependentName, int bookingID) {
		
		this.animalOrderID = animalOrderID;
		this.animalPartType = animalPartType;
		this.dependentName = dependentName;
		this.bookingID = bookingID;
	}
	
	// without ID
	public AnimalOrder(String animalPartType, String dependentName, int bookingID) {
		
		this.animalPartType = animalPartType;
		this.dependentName = dependentName;
		this.bookingID = bookingID;
	}
	
	// Setters ---------------------------
	public void setAnimalOrderID(int animalOrderID) {
		this.animalOrderID = animalOrderID;
	}
	
	public void setAnimalPartType(String animalPartType) {
		this.animalPartType = animalPartType;
	}

	public void setDependentName(String dependentName) {
		this.dependentName = dependentName;
	}
	
	public void setBookingID(int bookingID) {
		this.bookingID = bookingID;
	}
	
	// Getters ------------------------------
	public int getAnimalOrderID() {
		return animalOrderID;
	}

	public String getAnimalPartType() {
		return animalPartType;
	}

	public String getDependentName() {
		return dependentName;
	}

	public int getBookingID() {
		return bookingID;
	}

	
}
