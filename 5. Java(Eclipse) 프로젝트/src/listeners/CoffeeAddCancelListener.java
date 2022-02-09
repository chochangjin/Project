package listeners;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;

import GUI.CoffeeAdder;
import GUI.CoffeeViewer;
import GUI.WindowFrame;

public class CoffeeAddCancelListener implements ActionListener {

	WindowFrame frame;
	
	public CoffeeAddCancelListener(WindowFrame frame) {
		this.frame = frame;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		frame.getContentPane().removeAll();
		frame.getContentPane().add(frame.getMenuselection());
		frame.revalidate();
		frame.repaint();
	}

}
