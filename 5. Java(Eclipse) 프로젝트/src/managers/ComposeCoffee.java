package managers;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Scanner;

import GUI.WindowFrame;
import log.EventLogger;

public class ComposeCoffee {
	static EventLogger logger = new EventLogger("log.txt");
	
	public static void main(String[] args) {
				
		Scanner input = new Scanner(System.in);
		CoffeeManager coffeemanager = getObject("coffeemanager.ser");
		if (coffeemanager == null) {
			coffeemanager = new CoffeeManager(input);
		}
		
		WindowFrame frame = new WindowFrame(coffeemanager);
	    
		int num=0;
		
		while (num != 6) {
			printmenu();
			
		while ((num = input.nextInt()) !=6 ) {
			switch (num) {
				case (1) : 
					coffeemanager.addProduct(); 
					logger.log("add a Product"); 
					break; 
				case (2) : 
					coffeemanager.deleteProduct(); 
					logger.log("delete a Product"); 
					break;
				case (3) : 
					coffeemanager.editProduct(); 
					logger.log("edit a Product"); 
					break;
				case (4) : 
					coffeemanager.viewProducts(); 
					logger.log("view Products"); 
					break;
				case (5) : break;
				default :
					System.out.println("메뉴를 잘못 선택하셨습니다." + "\n");
				}
			printmenu();
			}
		}
		putObject(coffeemanager,"coffeemanager.ser");
	}
	
	static public void printmenu() {
		System.out.println("1. Add Product");
		System.out.println("2. Delete Product");
		System.out.println("3. Edit Product");
		System.out.println("4. View Products");
		System.out.println("5. Show a menu");
		System.out.println("6. Exit");
		System.out.println("Select one number between 1-6: ");
	}
	
	public static CoffeeManager getObject(String filename) {
		CoffeeManager coffeemanager = null;
		
		try {
			FileInputStream file = new FileInputStream(filename);
			ObjectInputStream in = new ObjectInputStream(file);
			
			coffeemanager = (CoffeeManager) in.readObject();
			
			in.close();
			file.close();
			
		} catch (FileNotFoundException e) {
			return coffeemanager;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return coffeemanager;
	}
	
	public static void putObject(CoffeeManager coffeemanager, String filename) {
		try {
			FileOutputStream file = new FileOutputStream(filename);
			ObjectOutputStream out = new ObjectOutputStream(file);
			
			out.writeObject(coffeemanager);
			
			out.close();
			file.close();
			
		} catch (FileNotFoundException e) {
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}

