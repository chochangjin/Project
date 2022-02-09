package managers;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Scanner;
import Coffee.AdeCoffee;
import Coffee.Coffee;
import Coffee.CoffeeCoffee;
import Coffee.CoffeeInput;
import Coffee.CoffeeKind;
import Coffee.JuiceCoffee;
import Coffee.TeaCoffee;
import log.EventLogger;

public class CoffeeManager implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6611855772552933427L;
	
	ArrayList<CoffeeInput> coffees = new ArrayList<CoffeeInput>();
	transient Scanner input;
	CoffeeInput coffeeinput;
	
	CoffeeManager(Scanner input) {
		this.input = input; 
	}
	
	public void addProduct(CoffeeInput coffeeinput) {
		coffees.add(coffeeinput); 
	}
	
	public void addProduct() {
		int kind = 0;
		
		while (kind !=1 && kind !=2 && kind !=3 && kind !=4) {
			System.out.println("Select Coffee Kind :");
			System.out.println("1 for Coffee");
			System.out.println("2 for Juice");
			System.out.println("3 for Ade");
			System.out.println("4 for Tea");
			System.out.println("Select num for Coffee Kind 1 ~ 4 :");
			kind = input.nextInt();
			String ckind = getKind(kind);
	}
}
	
	public String getKind(int kind) {
		String ckind = "None";
		switch (kind) {
		case 1: 
			coffeeinput = new CoffeeCoffee();
			coffeeinput.getCoffeeInput(input);
			coffees.add(coffeeinput); 
			ckind = "Coffee";
			break; 
		case 2: 
			coffeeinput = new JuiceCoffee();
			coffeeinput.getCoffeeInput(input);
			coffees.add(coffeeinput); 
			ckind = "Juice";
			break;
		case 3: 
			coffeeinput = new AdeCoffee();
			coffeeinput.getCoffeeInput(input);
			coffees.add(coffeeinput);
			ckind = "Ade";
			break;
		case 4: 
			coffeeinput = new TeaCoffee();
			coffeeinput.getCoffeeInput(input);
			coffees.add(coffeeinput);
			ckind = "Tea";
			break;
		default :
			System.out.println("Select num for Coffee Kind between 1 ~ 4 :");
		}
		return ckind;
	}
	
		
	public void deleteProduct() {
		System.out.println("Write the Product Number you want to delete.");
		System.out.println("Product Number: ");
		int Pnum = input.nextInt();
		int index = findIndex(Pnum);
		removefromCoffees(index,Pnum);
		}
		
	public void editProduct() {
		System.out.println("Write the Product Number you want to edit.");
		System.out.println("Product Number: ");
		int Pnum = input.nextInt();
		
		for (int i=0; i<coffees.size(); i++) {
			if (coffees.get(i).getPnum() == Pnum) {
				System.out.println("Choose the option you want to change.(1:Product Name, 2:Product Price)");
				int choose= input.nextInt();
				
				switch(choose) {
				case 1:
					System.out.println("Write the Product Name you want to change.");
					String edit = input.next();
					coffees.get(i).setPname(edit);
					break;
				case 2: 
					System.out.println("Write the Product Price you want to change.");
					int edit2 = input.nextInt();
					coffees.get(i).setPrice(edit2);
					break;
				default:
					continue;
				}
			}
		}
	}

	public void viewProducts() {
//		System.out.println("Write the product number you want to view.");
//		System.out.println("Product Number: ");
//		int Pnum = input.nextInt();
		for (int i=0; i<coffees.size(); i++) {
			coffees.get(i).printInfo();
		}
	}
	
	public int size() {
		return coffees.size();
	}

	public CoffeeInput get(int index) {
		return (Coffee) coffees.get(index);
	}
	
	public int removefromCoffees(int index, int Pnum) {
		if(index >= 0) {
			coffees.remove(index);
			System.out.println("The Product Number (" + Pnum + ") is deleted");
			return 1;
		}
		else {
			System.out.println("The Product Number is empty");
			return -1;
		}
	}
	
	public int findIndex(int Pnum) {
		int index = -1;
		
		for (int i=0; i<coffees.size(); i++) {
			if (coffees.get(i).getPnum() == Pnum) {
				index = i;
				break;
			}
		}
		return index;
	}
}
