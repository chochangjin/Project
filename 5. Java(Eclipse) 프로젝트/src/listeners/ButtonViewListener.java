package listeners;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;

import javax.swing.JButton;

import GUI.CoffeeViewer;
import GUI.WindowFrame;
import managers.CoffeeManager;

public class ButtonViewListener implements ActionListener {

	WindowFrame frame;
	
	public ButtonViewListener(WindowFrame frame) {
		this.frame = frame;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		CoffeeManager coffeemanager = getObject("coffeemanager.ser");
		CoffeeViewer coffeeviewer = frame.getCoffeeviewer();
		coffeeviewer.setCoffeemanager(coffeemanager);
		
		frame.getContentPane().removeAll();
		frame.getContentPane().add(coffeeviewer);
		frame.revalidate();
		frame.repaint();
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

}
