
public class Validation {

	boolean isValidName(String name) {
		return name.length() >=5 && name.length() <= 15;
	}
	
	boolean isValidType(String type) {
		return type.contentEquals("hare") || type.contentEquals("turtle");
	}
	
	boolean isValidChoice(int choice) {
		return choice >= 1 && choice <= 4;
	}

}
