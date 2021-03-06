package Coffee;

import java.util.InputMismatchException;
import java.util.Scanner;

public class TeaCoffee extends Coffee {
	
	char answer = 'x';
	
	public void getCoffeeInput(Scanner input) {
		setPnum(input);
		
		setPname(input);
		
		check(input);
	}
	
	public void printInfo() {
		System.out.println("Product Number : " + Pnum);
		System.out.println("Product Name : " + Pname);
		System.out.println("Product Price : " + price);
		System.out.println("Large size : " + answer);
	}
	
	public void check(Scanner input) {
		boolean error = true;
		while (error) {
			try {
				System.out.println("Do you want to upgrade Large size? (Y/N)");
				while (answer != 'y' || answer != 'Y' || answer != 'n' || answer != 'N') {
					answer = input.next().charAt(0);
					if (answer == 'y' || answer == 'Y') {
						System.out.println("Product Price: ");
						int price = input.nextInt() + 1000;
						this.setPrice(price);
						break;
					}
					else if (answer == 'n' || answer == 'N') {
						System.out.println("Product Price: ");
						int price = input.nextInt();
						this.setPrice(price);
						break;
					}
				}
				break;
			}
			catch(InputMismatchException e) {
				System.out.println("숫자를 입력하세요!");
			}
		}
	}
}
