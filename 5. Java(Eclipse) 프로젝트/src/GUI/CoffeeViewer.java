package GUI;

import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

import Coffee.CoffeeInput;
import managers.CoffeeManager;

public class CoffeeViewer extends JPanel {
	
	WindowFrame frame;
	CoffeeManager coffeemanager;
	
	public CoffeeManager getCoffeemanager() {
		return coffeemanager;
	}

	public void setCoffeemanager(CoffeeManager coffeemanager) {
		this.coffeemanager = coffeemanager;
		this.removeAll();
		
		DefaultTableModel model = new DefaultTableModel();
		model.addColumn("Number");
		model.addColumn("Name");
		model.addColumn("Price");
		
		for (int i=0; i<coffeemanager.size(); i++) {
			Vector row = new Vector();
			CoffeeInput ci = coffeemanager.get(i);
			row.add(ci.getPnum());
			row.add(ci.getPname());
			row.add(ci.getPrice());
			model.addRow(row);
		}
		
		JTable table = new JTable(model);
		JScrollPane sp = new JScrollPane(table);
		
		this.add(sp);
	}

	public CoffeeViewer(WindowFrame frame, CoffeeManager coffeemanager) {
		this.frame = frame;
		this.coffeemanager = coffeemanager;
		 
		System.out.println("***" + coffeemanager.size());
		
		DefaultTableModel model = new DefaultTableModel();
		model.addColumn("Number");
		model.addColumn("Name");
		model.addColumn("Price");
		
		for (int i=0; i<coffeemanager.size(); i++) {
			Vector row = new Vector();
			CoffeeInput ci = coffeemanager.get(i);
			row.add(ci.getPnum());
			row.add(ci.getPname());
			row.add(ci.getPrice());
			model.addRow(row);
		}
		
		JTable table = new JTable(model);
		JScrollPane sp = new JScrollPane(table);
		
		this.add(sp);
	}
}
