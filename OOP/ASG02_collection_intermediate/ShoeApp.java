import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Scanner;

public class ShoeApp {
	
	Scanner scan = new Scanner(System.in);
	ArrayList<Shoe> shoes = new ArrayList<>();
	
	public void viewShoes() {
		if(shoes.isEmpty()) {
			System.out.println("No Shoes Available");
			System.out.println("PRess enter to continue..");
			scan.nextLine();
			return;
		}
		
		for(int i = 1; i<=shoes.size(); i++) {
			System.out.println(i + shoes.get(i-1).toString());
		}
	}
	
	public void deleteShoe() {
//		5 shoes = 1..5
		
		int index = -1;
		int size = shoes.size();
		boolean isValidIndex = true;

		do {
			isValidIndex = true;
			index = scan.nextInt(); scan.nextLine();
			if(index < 1 || index > size) {
				isValidIndex = false;
			}			
		} while(!isValidIndex);
		shoes.remove(index-1);
		System.out.println("Shoe Removed!");
	}
	
	public void addShoe() {
		String name = null;
		boolean isValidName = true;
		
		do {
			isValidName = true;
			name = scan.nextLine();
			isValidName = name.endsWith("shoe") ? true : false;
		} while(!isValidName);
		
		String category = null;
		boolean isValidCategory = true;
		
		do {
			category = scan.nextLine();
			isValidCategory = (category.contentEquals("Sneaker") ||
							   category.contentEquals("Running") || 
							   category.contentEquals("Boot")) ? true: false;
		} while(!isValidCategory);
		
		String date = null;
		boolean isValidDate = true;
		
		do {
			isValidDate = true;
			date = scan.nextLine();
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("dd-mm-yyyy");
				sdf.setLenient(false); // don't Interpret false dates (help to parse)
				sdf.parse(date); // if fail, catch the ParseException
			} catch(ParseException pe) {
				isValidDate = false;
			}
		} while(!isValidDate);
		
		Integer price = -1;
		boolean isValidPrice = true;
		
		do {
			isValidPrice = true;
			price = scan.nextInt(); scan.nextLine();
			isValidPrice = (price >= 5000) ? true : false;
		} while(!isValidPrice);
		
		Shoe newShoe = new Shoe(name, category, date, price);
		shoes.add(newShoe);
	}

	public ShoeApp(boolean onApp) {
		while(onApp) {
			System.out.println("Shoe Shop");
			System.out.println("=========");
			System.out.println("1. View Shoe");
			System.out.println("2. Add Shoe");
			System.out.println("3. Delete Shoe");
			System.out.println("4. Exit");
			
			int choice = -2;
			boolean isValidChoice = true;
			
			do {
				System.out.println(">> ");
				choice = scan.nextInt(); scan.nextLine();
				if(choice < 1 || choice > 4) {
					isValidChoice = false;
				}
			} while(!isValidChoice);
			
			switch(choice) {
				case 1:
					viewShoes();
					break;
				case 2:
					addShoe();
					break;
				case 3:
//					deleteShoe();
					break;
				case 4:
					System.out.println("Thank you!");
					onApp = false;
					break;
			}
		}
	}

	public static void main(String[] args) {
		new ShoeApp(true);
	}

}
