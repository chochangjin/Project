package GUI;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SpringLayout;

import listeners.CoffeeAddCancelListener;
import listeners.CoffeeAdderListener;
import managers.CoffeeManager;


public class CoffeeAdder extends JPanel {
	
	WindowFrame frame;
	
	CoffeeManager coffeemanager;
	
	public CoffeeAdder(WindowFrame frame, CoffeeManager coffeemanager) {
		this.frame = frame;
		this.coffeemanager = coffeemanager;
		
		JPanel panel = new JPanel();
		panel.setLayout(new SpringLayout());;
		
		JLabel labelPnum = new JLabel("Product Number : ", JLabel.TRAILING);
		JTextField fieldPnum = new JTextField(10);
		labelPnum.setLabelFor(fieldPnum);
		panel.add(labelPnum);
		panel.add(fieldPnum);
		
		JLabel labelPname = new JLabel("Product Name : ", JLabel.TRAILING);
		JTextField fieldPname = new JTextField(10);
		labelPnum.setLabelFor(fieldPname);
		panel.add(labelPname);
		panel.add(fieldPname);
		
		JLabel labelPrice = new JLabel("Product Price : ", JLabel.TRAILING);
		JTextField fieldPrice = new JTextField(10);
		labelPnum.setLabelFor(fieldPrice);
		
		JButton saveButton = new JButton("save");
		saveButton.addActionListener(new CoffeeAdderListener(fieldPnum, fieldPname, fieldPrice, coffeemanager));
		
		JButton cancelButton = new JButton("cancel");
		cancelButton.addActionListener(new CoffeeAddCancelListener(frame));
		
		panel.add(labelPrice);
		panel.add(fieldPrice);
		
		panel.add(saveButton);
		panel.add(cancelButton);
		
		SpringUtilities.makeCompactGrid(panel, 4, 2, 6, 6, 6, 6);

		this.add(panel);
		this.setVisible(true);
		
	}
}
