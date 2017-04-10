package com.andrewringler.artscreenworkshop;

import java.awt.Color;
import java.awt.FlowLayout;
import java.lang.reflect.InvocationTargetException;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

public class LoadingScreen {
	public static void showBlankBackdrop() throws InvocationTargetException, InterruptedException {
		SwingUtilities.invokeAndWait(new Runnable() {
			@Override
			public void run() {
				JFrame frame = new JFrame();
				frame.setAlwaysOnTop(false);
				frame.setResizable(false);
				frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
				frame.setUndecorated(true);
				
				JPanel newContentPane = new JPanel(new FlowLayout());
				newContentPane.setBackground(Color.black);
				newContentPane.setOpaque(true);
				frame.setContentPane(newContentPane);
				frame.pack();
				
				frame.setVisible(true);
			}
		});
		
	}
}
