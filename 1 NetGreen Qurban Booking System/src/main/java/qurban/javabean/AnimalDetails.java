package qurban.javabean;

public class AnimalDetails {
	private int animalDetailsID;	
	private String animalType;		// Jenis haiwan
	private double animalPrice;		// Harga seekor
	private String supplierName;	// Nama pembekal
	
	// Constructor -------------------------------------
	
	// With ID
	public AnimalDetails(int animalDetailsID, String animalType, double animalPrice, String supplierName) {

		this.animalDetailsID = animalDetailsID;
		this.animalType = animalType;
		this.animalPrice = animalPrice;
		this.supplierName = supplierName;
	}
	
	// Without ID
	public AnimalDetails(String animalType, double animalPrice, String supplierName) {
		
		this.animalType = animalType;
		this.animalPrice = animalPrice;
		this.supplierName = supplierName;
	}
	
	// Default
	public AnimalDetails() {
		
	}


	// Setters ---------------------------------

	public void setAnimalDetailsID(int animalDetailsID) {
		this.animalDetailsID = animalDetailsID;
	}
	
	public void setAnimalType(String animalType) {
		this.animalType = animalType;
	}

	public void setAnimalPrice(double animalPrice) {
		this.animalPrice = animalPrice;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	
	// Getters ---------------------------------
	
	public int getAnimalDetailsID() {
		return animalDetailsID;
	}

	public String getAnimalType() {
		return animalType;
	}

	public double getAnimalPrice() {
		return animalPrice;
	}

	public String getSupplierName() {
		return supplierName;
	}

}
