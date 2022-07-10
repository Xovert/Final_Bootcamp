import java.util.ArrayList;
import java.util.Scanner;

public class App {
	
	Validation validate = new Validation();
	Scanner scan = new Scanner(System.in);
	ArrayList<Runner> runners = new ArrayList<>();
	int hareScore, turtleScore;

	public App(boolean onApp) {
		while (onApp) {
			System.out.println("1. Add Runner");
			System.out.println("2. Join Run");
			System.out.println("3. View Standing");
			System.out.println("4. Close Program");
			
			int choice;
			do {
				System.out.print(">> ");
				choice = scan.nextInt(); scan.nextLine();
			} while (!validate.isValidChoice(choice));
			
			switch(choice) {
			case 1:
				addRunner();
				break;
			case 2:
				joinRun();
				break;
			case 3:
				viewStanding();
				break;
			case 4:
				onApp = false;
				break;
			}
		}
		System.out.println("Hello World!");
	}

	private void joinRun() {
		Leaderboard board = new Leaderboard(runners);
		
		while(board.isRunning) {
			board.updateBoard();
			board.showBoard();
		}
		
		board.resetBoard();
		
		if(board.winner instanceof Hare) {
			hareScore++;
		} else {
			turtleScore++;
		}
		
	}

	void viewStanding() {
		if(hareScore == turtleScore) {
			System.out.println("Draw");
		} else if (hareScore > turtleScore) {
			System.out.println("Hare wins!");
		} else {
			System.out.println("Turtle wins!");
		}
	}
	private void addRunner() {
		String name, type;
		 
		do {
			System.out.print("Name: ");
			name = scan.nextLine();
		}while(!validate.isValidName(name));
		
		do {
			System.out.print("Type: ");
			type = scan.nextLine();
		} while(!validate.isValidType(type));
		
		if(type.contentEquals("hare")) {
			runners.add(new Hare(name, type));
		} else {
			runners.add(new Turtle(name, type));
		}
		
		System.out.println("Another runner has joined the race!");
	}

	public static void main(String[] args) {
		new App(true);
	}

}
