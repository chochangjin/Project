package Coffee;

import java.io.Serializable;
import java.util.Scanner;

public abstract class Coffee implements CoffeeInput, Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected CoffeeKind kind = CoffeeKind.Coffee;
	protected int Pnum;
	protected String Pname;
	protected int price;
	
	public Coffee() {
	}
	
	public Coffee(int Pnum,  String Pname, int price) {
		this.Pnum = Pnum;
		this.Pname = Pname;
		this.price = price;
	}
	
	public CoffeeKind getKind() {
		return kind;
	}

	public void setKind(CoffeeKind kind) {
		this.kind = kind;
	}

	public int getPnum() {
		return Pnum;
	}

	public void setPnum(int pnum) {
		Pnum = pnum;
	}

	public String getPname() {
		return Pname;
	}

	public void setPname(String pname) {
		Pname = pname;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	public abstract void printInfo();
	
	public void getCoffeeInput(Scanner input) {
		System.out.println("Product Number: ");
		int Pnum = input.nextInt();
		this.setPnum(Pnum);
		
		System.out.println("Product Name: ");
		String Pname = input.next();
		this.setPname(Pname);
		 
		System.out.println("Product Price: ");
		int price = input.nextInt();
		this.setPrice(price);
	}
	
	public void setPnum(Scanner input) {
		System.out.println("Product Number: ");
		int Pnum = input.nextInt();
		this.setPnum(Pnum);
	}
	
	public void setPname(Scanner input) {
		System.out.println("Product Name: ");
		String Pname = input.next();
		this.setPname(Pname);
	}
	
}
