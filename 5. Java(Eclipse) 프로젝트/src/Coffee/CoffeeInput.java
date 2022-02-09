package Coffee;

import java.util.Scanner;

public interface CoffeeInput {
	
	public void getCoffeeInput(Scanner input);
	
	public int getPnum();
	
	public String getPname();
	
	public int getPrice();
	
	public void setPrice(int price);
	
	public void printInfo();
	
	public void setPnum(int pnum);
	
	public void setPname(String pname);
	
	public void setPnum(Scanner input);
	
	public void setPname(Scanner input);
	
}
