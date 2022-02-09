package listeners;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;

import javax.swing.JTextField;

import Coffee.CoffeeCoffee;
import Coffee.CoffeeInput;
import managers.CoffeeManager;

public class CoffeeAdderListener implements ActionListener {
	JTextField fieldPnum;
	JTextField fieldPname;
	JTextField fieldPrice;
	
	CoffeeManager coffeemanager;

	public CoffeeAdderListener(
			JTextField fieldPnum, 
			JTextField fieldPname, 
			JTextField fieldPrice, CoffeeManager coffeemanager) {
		this.fieldPnum = fieldPnum;
		this.fieldPname = fieldPname;
		this.fieldPrice = fieldPrice;
		this.coffeemanager = coffeemanager;
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		System.out.println(fieldPnum.getText());
		System.out.println(fieldPname.getText());
		System.out.println(fieldPrice.getText());		
		
		CoffeeInput coffee = new CoffeeCoffee();
		coffee.setPnum(Integer.parseInt(fieldPnum.getText()));
		coffee.setPname(fieldPname.getText());
		coffee.setPrice(Integer.parseInt(fieldPrice.getText()));
		coffeemanager.addProduct(coffee);
		putObject(coffeemanager, "coffeemanager.ser");
		coffee.printInfo();
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
