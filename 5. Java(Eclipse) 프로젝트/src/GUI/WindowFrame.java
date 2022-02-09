package GUI;

import javax.swing.JFrame;
import javax.swing.JPanel;

import managers.CoffeeManager;


public class WindowFrame extends JFrame {
	
	CoffeeManager coffeemanager;
	
	MenuSelection menuselection;
	CoffeeAdder coffeeadder;
	CoffeeViewer coffeeviewer;

	
	public WindowFrame(CoffeeManager coffeemanager) {
		this.coffeemanager = coffeemanager;
		this.menuselection = new MenuSelection(this);
		this.coffeeadder = new CoffeeAdder(this, this.coffeemanager);
		this.coffeeviewer = new CoffeeViewer(this, this.coffeemanager);
		
		this.setSize(500, 300);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		this.setupPanel(menuselection);
		
		this.setVisible(true);
	}

	public void setupPanel(JPanel panel) {
		this.getContentPane().removeAll();
		this.getContentPane().add(panel);
		this.revalidate();
		this.repaint();
	}
	
	
	public MenuSelection getMenuselection() {
		return menuselection;
	}

	public void setMenuselection(MenuSelection menuselection) {
		this.menuselection = menuselection;
	}

	public CoffeeAdder getCoffeeadder() {
		return coffeeadder;
	}

	public void setCoffeeadder(CoffeeAdder coffeeadder) {
		this.coffeeadder = coffeeadder;
	}

	public CoffeeViewer getCoffeeviewer() {
		return coffeeviewer;
	}

	public void setCoffeviewer(CoffeeViewer coffeeviewer) {
		this.coffeeviewer = coffeeviewer;
	}
	
}
